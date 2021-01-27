
import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/local/user_local.dart';
import 'package:zimvest/data/models/secondary_state.dart';
import 'package:zimvest/locator.dart';
import 'package:zimvest/new_screens/account/temp_login_screen.dart';

import 'main.dart';


class BaseScreen extends StatefulWidget {
  final Widget child;

  const BaseScreen({Key key,@required this.child}) : super(key: key);
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> with AfterLayoutMixin<BaseScreen>, WidgetsBindingObserver {

  final ABSStateLocalStorage _localStorage = locator<ABSStateLocalStorage>();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    print("opkkopkp 123456789");
    WidgetsBinding.instance.addObserver(this);
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
        _showItemDialog(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _navigateToItemDetail(message);
      },

    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("stateee $state");
    if (state == AppLifecycleState.resumed) {
      print("App Resumed");
      if (_localStorage.getSecondaryState().lastMinimized == null ||
          _localStorage.getSecondaryState().email == null) {
        return;
      }
      print(
          "App Resumed 2 ${DateTime.now().difference(_localStorage.getSecondaryState().lastMinimized).inSeconds}");
      print("App Resumed 211 ${_localStorage.getSecondaryState().lastMinimized.toIso8601String()}");
      print("App Resumed biometrics  ${_localStorage.getSecondaryState().biometricsEnabled}");
      print("App Resumed 2ww ${DateTime.now().toIso8601String()}");
      if (DateTime.now()
          .difference(_localStorage.getSecondaryState().lastMinimized)
          .inSeconds >
          150) {
        print("App should stop");
        SecondaryState state = SecondaryState(false,
            email: _localStorage.getSecondaryState().email,
            password: _localStorage.getSecondaryState().password,
            biometricsEnabled:
            _localStorage.getSecondaryState().biometricsEnabled);
        _localStorage.saveSecondaryState(state);
        locator<NavigationService>().navigateTo1(TempLoginScreen.route(show: true));
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => TempLoginScreen(
        //           show: true,
        //         )),
        //         (Route<dynamic> route) => false);
      }
    } else if (state == AppLifecycleState.inactive) {
      print("App inactive");
    } else if (state == AppLifecycleState.paused) {
      DateTime time = DateTime.now();
      SecondaryState secondaryState = _localStorage.getSecondaryState();
      secondaryState.lastMinimized = time;
      print("kkkk ${secondaryState.lastMinimized.toIso8601String()}");
      print("biometrics ${secondaryState.biometricsEnabled}");

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
    return widget.child;
  }



  @override
  void afterFirstLayout(BuildContext context) {

    this.initDynamicLinks(context);
  }

  initDynamicLinks(BuildContext context) async {
    //await Future.delayed(Duration(seconds: 3));
    //
    // try{
    //   var data = await FirebaseDynamicLinks.instance.getInitialLink();
    //   var deepLink = data?.link;
    //   final queryParams = deepLink.queryParameters;
    //
    //   if (queryParams.length > 0) {
    //     var quizId = queryParams[AppStrings.quizTag()];
    //     var quizIdPrivate = queryParams[AppStrings.quizTag(private: true)];
    //     var userId = queryParams['referral'];
    //
    //     print("....123 $quizId -- $quizIdPrivate -- $userId");
    //
    //
    //     if(quizId != null){
    //       Navigator.push(context, QuizDetailsScreen.route(quizId,private: false));
    //     }
    //     if(quizIdPrivate != null){
    //       Navigator.push(context, QuizDetailsScreen.route(quizIdPrivate,private: true));
    //     }
    //     if(userId != null){
    //       userViewModel.referralUserId = userId;
    //     }
    //   }// https://choxquiz.page.link/u4bY4ev3jFRoeLXr9
    //   FirebaseDynamicLinks.instance.onLink(onSuccess: (dynamicLink)
    //   async {
    //     //AppUtils.shwSuccess(context, "111133333");
    //     var deepLink = dynamicLink?.link;
    //     debugPrint('DynamicLinks onLink $deepLink');
    //   }, onError: (e) async {
    //     //AppUtils.shwError(context, "111133333");
    //     debugPrint('DynamicLinks onError $e');
    //   });
    // }catch(e){
    //   //AppUtils.shwError(context, "${e.toString()}");
    // }

  }


  void _showItemDialog(Map<String, dynamic> message) {}

  void _navigateToItemDetail(Map<String, dynamic> message) {}
}



