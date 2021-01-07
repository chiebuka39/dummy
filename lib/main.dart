import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/local/user_local.dart';
import 'package:zimvest/data/services/connectivity_service.dart';
import 'package:zimvest/data/view_models/dashboard_view_model.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
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


void main()async {
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
  runApp(MyApp());
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
        ChangeNotifierProvider<ABSIdentityViewModel>(create: (_) => IdentityViewModel(),),
        ChangeNotifierProvider<ABSDashboardViewModel>(create: (_) => DashboardViewModel(),),
        ChangeNotifierProvider<ABSPaymentViewModel>(create: (_) => PaymentViewModel(),),
        ChangeNotifierProvider<ABSSavingViewModel>(create: (_) => SavingViewModel(),),
        ChangeNotifierProvider<ABSPinViewModel>(create: (_) => PinViewModel(),),
        ChangeNotifierProvider<ABSInvestmentViewModel>(create: (_) => InvestmentViewModel(),),
        ChangeNotifierProvider<ABSSettingsViewModel>(create: (_) => SettingsViewModel(),),
        ChangeNotifierProvider<ABSOthersViewModel>(create: (_) => OthersViewModel(),),
        ChangeNotifierProvider<ConnectionProvider>(create: (_) => ConnectionProvider()),
      ],
      child: MaterialApp(
        title: 'Zimvest',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Caros",
          primarySwatch: Colors.blue,
          bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent),

          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        builder: EasyLoading.init(),
        home:HomeApp(),
      ),
    );
  }
}

class HomeApp extends StatefulWidget  {
  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> with WidgetsBindingObserver {
  final ABSStateLocalStorage _localStorage = locator<ABSStateLocalStorage>();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  @override
  void initState() {
    User user = _localStorage.getUser();
    print("llll ${_localStorage.getSecondaryState().password}");
    print("llll ${_localStorage.getSecondaryState().email}");
    if(user != null){
      if(user.expires.difference(DateTime.now()).inSeconds < 0){
        SecondaryState state = SecondaryState(false, email: _localStorage.getSecondaryState().email, password: _localStorage.getSecondaryState().password);
        _localStorage.saveSecondaryState(state);
      }
    }

    WidgetsBinding.instance.addObserver(this);


    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("stateee $state");
    if (state == AppLifecycleState.resumed) {
      print("App Resumed");
      if(_localStorage.getSecondaryState().lastMinimized == null){
        return;
      }
      print("App Resumed 2 ${DateTime.now().difference(_localStorage.getSecondaryState().lastMinimized).inSeconds}");
      print("App Resumed 211 ${_localStorage.getSecondaryState().lastMinimized.toIso8601String()}");
      print("App Resumed 2ww ${DateTime.now().toIso8601String()}");
      if(DateTime.now().difference(_localStorage.getSecondaryState().lastMinimized).inSeconds > 150){
        print("App should stop");
        SecondaryState state = SecondaryState(false, email: _localStorage.getSecondaryState().email, password: _localStorage.getSecondaryState().password);
        _localStorage.saveSecondaryState(state);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => TempLoginScreen(show: true,)),
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


  @override
  Widget build(BuildContext context) {
    SecondaryState state = _localStorage.getSecondaryState();
    User user = _localStorage.getUser();
    return state.isLoggedIn == false ? user == null ?  LandingScreen(): TempLoginScreen(show: true,) :TabsContainer();
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
    ..progressColor = Colors.yellow
    ..backgroundColor = AppColors.kSecondaryColor
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskType = EasyLoadingMaskType.black
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false;
}

class LoadingWIdget extends StatefulWidget {
  const LoadingWIdget({
    Key key,
  }) : super(key: key);

  @override
  _LoadingWIdgetState createState() => _LoadingWIdgetState();
}

class _LoadingWIdgetState extends State<LoadingWIdget> with SingleTickerProviderStateMixin {

  AnimationController controller;

  Animation<double> animation;

  @override
  void initState() {
    controller = AnimationController(vsync:this,duration: Duration(seconds: 1));
    controller.repeat(reverse: true);
    animation =  Tween(begin: 0.2,end: 0.5).animate(controller)..addListener(() {
      setState(() {

      });
    });

    super.initState();
  }
  void _startAnimation() {
    controller.stop();
    controller.reset();
    controller.repeat(
      period: Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: AppColors.kSecondaryColor,
        borderRadius: BorderRadius.circular(7)
      ),
      child: Center(child: Stack(
        children: [
          SizedBox(
            height: 70,
            width: 70,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.kPrimaryColor),),
          ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Transform.scale(
                scale: animation.value,
                  child: SvgPicture.asset("images/new/zed.svg")),
            )

        ],
      ),
      ),
    );
  }
}


