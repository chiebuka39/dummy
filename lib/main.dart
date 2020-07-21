import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_mode.dart';
import 'package:zimvest/locator.dart';
import 'package:zimvest/screens/account/login_screen.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:zimvest/screens/menu_container.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  //init hive flutter
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  setUpLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ABSIdentityViewModel>(create: (_) => IdentityViewModel(),)
      ],
      child: MaterialApp(
        title: 'Zimvest',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Caros",
          primarySwatch: Colors.blue,

          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home:  LoginScreen(),
      ),
    );
  }
}


