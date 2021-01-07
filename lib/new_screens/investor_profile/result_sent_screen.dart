import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';
import 'package:zimvest/new_screens/tabs.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/new/anim.dart';

class ResultSentScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => ResultSentScreen(),
        settings:
        RouteSettings(name: ResultSentScreen().toStringShort()));
  }
  @override
  _ResultSentScreenState createState() => _ResultSentScreenState();
}
enum AniProps {   opacity1,offset1, scale }

class _ResultSentScreenState extends State<ResultSentScreen> {

  List<GlobalKey<ItemFaderState>> keys;

  final _tween = MultiTween<AniProps>()
    ..add(AniProps.offset1, Tween(begin: Offset(0, 10), end: Offset(0, 0)),
        800.milliseconds, Interval(0.0, 1.0, curve: Curves.easeIn,))
    ..add(AniProps.scale, Tween(begin: 0.0, end: 1.0),
        800.milliseconds, Interval(0.0, 0.6, curve: Curves.bounceInOut,))
    ..add(AniProps.opacity1, 0.0.tweenTo(1.0),
        800.milliseconds, Interval(0.0, 1.0, curve: Curves.ease,));

  @override
  void initState() {
    keys = List.generate(3, (index) => GlobalKey<ItemFaderState>());
    Future.delayed(300.milliseconds).then((value) => onInit());
    super.initState();
  }
  void onInit() async {
    for (var key in keys) {
      await Future.delayed(Duration(seconds: 1));
      key.currentState.show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PlayAnimation<MultiTweenValues<AniProps>>(
        tween: _tween,
        duration: _tween.duration,
        builder: (context, child, value){
          return Container(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                  Transform.scale(
                      scale: value.get(AniProps.scale),
                      child: Transform.translate(
                          offset: value.get(AniProps.offset1),
                          child: Opacity(
                              opacity: value.get(AniProps.opacity1),
                              child: SvgPicture.asset("images/new/success.svg")))),
                  YMargin(40),
                  ItemFader(
                      offset: 10,
                      curve: Curves.easeIn,
                      key: keys[0],
                      child: Text("Your Result Has Been Sent", style: TextStyle(color: AppColors.kTextColor),)),
                  YMargin(30),
                  ItemFader(
                      offset: 10,
                      curve: Curves.easeIn,
                      key: keys[1],
                      child: SizedBox(
                        width: 250,
                        child: Text("Your result has been sent to your email address, "
                            "you can check your spam if you don’t find in your mailbox", style: TextStyle(color: AppColors.kTextColor,
                            fontFamily: AppStrings.fontLight,fontSize: 12,height: 1.7 ),
                          textAlign: TextAlign.center,),
                      )),
                  Spacer(),
                  ItemFader(
                    offset: 10,
                    curve: Curves.easeIn,
                    key: keys[2],
                    child: PrimaryButtonNew(
                      onTap: (){
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => TabsContainer()),
                                (Route<dynamic> route) => false);
                      },
                      textColor: Colors.white,
                      title: "Done",
                      bg: AppColors.kPrimaryColor,
                    ),
                  ),
                  YMargin(100)
                ],),
            ),
          );
        },
      ),
    );
  }
}
