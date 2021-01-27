import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/animations/loading.dart';
import 'package:zimvest/data/local/user_local.dart';
import 'package:zimvest/data/services/connectivity_service.dart';
import 'package:zimvest/data/view_models/dashboard_view_model.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
import 'package:zimvest/data/view_models/liquidate_asset_vm.dart';
import 'package:zimvest/data/view_models/others_view_model.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/data/view_models/pin_view_model.dart';
import 'package:zimvest/data/view_models/savings_view_model.dart';
import 'package:zimvest/data/view_models/settings_view_model.dart';
import 'package:zimvest/locator.dart';
import 'package:zimvest/new_screens/account/temp_login_screen.dart';
import 'package:zimvest/new_screens/tabs.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/strings.dart';
import 'data/models/secondary_state.dart';
import 'data/models/user.dart';
import 'new_screens/landing_screen.dart';
import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //init hive flutter
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(SecondaryStateAdapter());

  //open up hive
  await Hive.openBox(AppStrings.state);

  //initialize service locator
  setUpLocator();
  runApp(
    // DevicePreview(
    //   builder: (context) =>
    MyApp(),
    //   enabled: !kReleaseMode,
    // ),
  );
  configLoading();
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ABSIdentityViewModel>(
          create: (_) => IdentityViewModel(),
        ),
        ChangeNotifierProvider<ABSDashboardViewModel>(
          create: (_) => DashboardViewModel(),
        ),
        ChangeNotifierProvider<ABSPaymentViewModel>(
          create: (_) => PaymentViewModel(),
        ),
        ChangeNotifierProvider<ABSSavingViewModel>(
          create: (_) => SavingViewModel(),
        ),
        ChangeNotifierProvider<ABSPinViewModel>(
          create: (_) => PinViewModel(),
        ),
        ChangeNotifierProvider<ABSInvestmentViewModel>(
          create: (_) => InvestmentViewModel(),
        ),
        ChangeNotifierProvider<ABSSettingsViewModel>(
          create: (_) => SettingsViewModel(),
        ),
        ChangeNotifierProvider<ABSOthersViewModel>(
          create: (_) => OthersViewModel(),
        ),
        ChangeNotifierProvider<ConnectionProvider>(
            create: (_) => ConnectionProvider()),

        ChangeNotifierProvider<LiquidateAssetViewModel>(
          create: (_) => LiquidateAssetViewModel(),
        )
      ],
      child: MaterialApp(
        title: 'Zimvest',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Caros",
          primarySwatch: Colors.blue,
          bottomSheetTheme:
              BottomSheetThemeData(backgroundColor: Colors.transparent),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        builder: EasyLoading.init(),
        home: HomeApp(),
      ),
    );
  }
}

class HomeApp extends StatefulWidget {
  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> with WidgetsBindingObserver {
  final ABSStateLocalStorage _localStorage = locator<ABSStateLocalStorage>();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  double _statusBarHeight = 0.0;
  StatusBarAnimation _statusBarAnimation = StatusBarAnimation.SLIDE;

  bool _navBarColorAnimated = false;
  Color _navBarColor = Colors.black;
  NavigationBarStyle _navBarStyle = NavigationBarStyle.DARK;

  @override
  void initState() {
    User user = _localStorage.getUser();
    print("llll ${_localStorage.getSecondaryState().password}");
    print("llll ${_localStorage.getSecondaryState().email}");
    if (user != null) {
      if (user.expires.difference(DateTime.now()).inSeconds < 0) {
        SecondaryState state = SecondaryState(false,
            email: _localStorage.getSecondaryState().email,
            password: _localStorage.getSecondaryState().password);
        _localStorage.saveSecondaryState(state);
      }
    }

    WidgetsBinding.instance.addObserver(this);

    initPlatformState();
    _setUPNotifications();
    super.initState();
  }
  Future<void> _setUPNotifications() async {
    if (Platform.isIOS) {
      _firebaseMessaging.requestNotificationPermissions(IosNotificationSettings());
    }
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("stateee $state");
    if (state == AppLifecycleState.resumed) {
      print("App Resumed");
      if (_localStorage.getSecondaryState().lastMinimized == null || _localStorage.getSecondaryState().email == null) {
        return;
      }
      print(
          "App Resumed 2 ${DateTime.now().difference(_localStorage.getSecondaryState().lastMinimized).inSeconds}");
      print(
          "App Resumed 211 ${_localStorage.getSecondaryState().lastMinimized.toIso8601String()}");
      print("App Resumed 2ww ${DateTime.now().toIso8601String()}");
      if (DateTime.now()
              .difference(_localStorage.getSecondaryState().lastMinimized)
              .inSeconds >
          150) {
        print("App should stop");
        SecondaryState state = SecondaryState(false,
            email: _localStorage.getSecondaryState().email,
            password: _localStorage.getSecondaryState().password,
          biometricsEnabled: _localStorage.getSecondaryState().biometricsEnabled
        );
        _localStorage.saveSecondaryState(state);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => TempLoginScreen(
                      show: true,
                    )),
            (Route<dynamic> route) => false);
      }
    } else if (state == AppLifecycleState.inactive) {
      print("App inactive");
    } else if (state == AppLifecycleState.paused) {
      DateTime time = DateTime.now();
      SecondaryState secondaryState = _localStorage.getSecondaryState();
      secondaryState.lastMinimized = time;
      print("kkkk ${secondaryState.lastMinimized.toIso8601String()}");

      _localStorage.saveSecondaryState(secondaryState);
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  Future<void> initPlatformState() async {
    double statusBarHeight;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      statusBarHeight = await FlutterStatusbarManager.getHeight;
    } on PlatformException {
      statusBarHeight = 0.0;
    }
    if (!mounted) return;

    setState(() {
      _statusBarHeight = statusBarHeight;
      FlutterStatusbarManager.setHidden(false, animation: _statusBarAnimation);
      FlutterStatusbarManager.setStyle(StatusBarStyle.DARK_CONTENT);
    });
  }

  @override
  Widget build(BuildContext context) {
    SecondaryState state = _localStorage.getSecondaryState();
    User user = _localStorage.getUser();
    return state.isLoggedIn == false
        ? user == null
            ? LandingScreen()
            : TempLoginScreen(
                show: true,
              )
        : TabsContainer();
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 500)
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..infoWidget = LoadingWIdget()
    ..indicatorWidget = LoadingWIdget()
    ..progressColor = Colors.yellow
    ..backgroundColor = AppColors.kSecondaryColor
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskType = EasyLoadingMaskType.black
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false;
}


