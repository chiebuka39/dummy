import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/local/user_local.dart';
import 'package:zimvest/data/view_models/dashboard_view_model.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
import 'package:zimvest/data/view_models/others_view_model.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/data/view_models/savings_view_model.dart';
import 'package:zimvest/data/view_models/settings_view_model.dart';
import 'package:zimvest/locator.dart';
import 'package:zimvest/new_screens/tabs.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:zimvest/utils/strings.dart';
import 'data/models/secondary_state.dart';
import 'data/models/user.dart';
import 'new_screens/landing_screen.dart';

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
    //   enabled: !kReleaseMode,
    //   builder: (context) =>
    MyApp(), // Wrap your app
    // ),
  );
  configLoading();
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ABSStateLocalStorage _localStorage = locator<ABSStateLocalStorage>();

  @override
  void initState() {
    User user = _localStorage.getUser();
    if (user != null) {
      if (user.expires.difference(DateTime.now()).inSeconds < 0) {
        _localStorage.saveSecondaryState(SecondaryState(false));
      }
    }

    super.initState();
  }

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
        ChangeNotifierProvider<ABSInvestmentViewModel>(
          create: (_) => InvestmentViewModel(),
        ),
        ChangeNotifierProvider<ABSSettingsViewModel>(
          create: (_) => SettingsViewModel(),
        ),
        ChangeNotifierProvider<ABSOthersViewModel>(
          create: (_) => OthersViewModel(),
        )
      ],
      // child: FlutterEasyLoading(
      child: MaterialApp(
        title: 'Zimvest',
        debugShowCheckedModeBanner: false,
        // builder: EasyLoading.init(),
        // navigatorKey: locator<NavigationService>().navigationKey,
        // onGenerateRoute: generateRoute,
        theme: ThemeData(
          fontFamily: "Caros",
          primarySwatch: Colors.blue,
          bottomSheetTheme:
              BottomSheetThemeData(backgroundColor: Colors.transparent),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: _localStorage.getSecondaryState().isLoggedIn == false
            ? LandingScreen()
            : TabsContainer(),

        // ),
      ),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 500)
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskType = EasyLoadingMaskType.black
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false;
}
