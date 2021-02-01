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
import 'package:zimvest/base_screen.dart';
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
import 'package:zimvest/data/view_models/wallets_view_model.dart';
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
    DevicePreview(
      builder: (context) =>
    MyApp(),
      enabled: !kReleaseMode,
    ),
  );
  configLoading();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: MultiProvider(
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
          ),
          ChangeNotifierProvider<WalletViewModel>(
            create: (_) => WalletViewModel(),
          ),
          ChangeNotifierProvider<InvestmentHighYieldViewModel>(
            create: (_) => InvestmentHighYieldViewModel(),
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
          navigatorKey: locator<NavigationService>().navigatorKey,
          home: HomeApp(),
        ),
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
            password: _localStorage.getSecondaryState().password,
            biometricsEnabled:
                _localStorage.getSecondaryState().biometricsEnabled);
        _localStorage.saveSecondaryState(state);
      }
    }

    initPlatformState();
    super.initState();
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

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState.pushNamed(routeName);
  }

  Future<dynamic> navigateTo1(Route<dynamic> route) {
    return navigatorKey.currentState.push(route);
  }
}
