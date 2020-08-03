import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/local/user_local.dart';
import 'package:zimvest/data/view_models/dashboard_view_model.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/locator.dart';
import 'package:zimvest/onboarding/onboarding_screen.dart';
import 'package:zimvest/screens/account/login_screen.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:zimvest/screens/menu_container.dart';
import 'package:zimvest/utils/strings.dart';

import 'data/models/secondary_state.dart';
import 'data/models/user.dart';


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
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final ABSStateLocalStorage _localStorage = locator<ABSStateLocalStorage>();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ABSIdentityViewModel>(create: (_) => IdentityViewModel(),),
        ChangeNotifierProvider<ABSDashboardViewModel>(create: (_) => DashboardViewModel(),),
        ChangeNotifierProvider<ABSPaymentViewModel>(create: (_) => PaymentViewModel(),)
      ],
      child: MaterialApp(
        title: 'Zimvest',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Caros",
          primarySwatch: Colors.blue,

          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home:_localStorage.getSecondaryState().isLoggedIn == false ?  OnboardingScreen(): MenuContainer(),
      ),
    );
  }
}


