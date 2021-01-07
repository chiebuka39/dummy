import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

class EarnFreeCashScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => EarnFreeCashScreen(),
        settings:
        RouteSettings(name: EarnFreeCashScreen().toStringShort()));
  }
  @override
  _EarnFreeCashScreenState createState() => _EarnFreeCashScreenState();
}

class _EarnFreeCashScreenState extends State<EarnFreeCashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ZimAppBar(
        text: "Earn Free Cash",
        callback: (){
          Navigator.pop(context);
        },
        icon: Icons.clear,
      ),
      body: Center(
        child: Column(children: [
          Spacer(),
          SvgPicture.asset("images/new/gift1.svg"),
          YMargin(45),
          Text("Get free ₦1000", style: TextStyle(fontSize: 21,
              fontFamily: AppStrings.fontMedium),),
          YMargin(26),
          SizedBox(
            width: 300,
            child: Text("Share your code to give your friends ₦1000 in rewards, "
                "after they sign up, you’ll also get ₦1000  in rewards  ",
              style: TextStyle(fontSize: 12,
                  fontFamily: AppStrings.fontLight,
                  height: 1.6),),
          ),
          YMargin(40),
          Container(
            height: 60,
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: AppColors.kPrimaryColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12)

            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(children: [
                Text("EMMWST", style: TextStyle(fontSize: 13,
                    fontFamily: AppStrings.fontMedium, color: AppColors.kPrimaryColor),),
                Spacer(),
                Text("TAP TO COPY", style: TextStyle(fontSize: 13,
                    fontFamily: AppStrings.fontMedium, color: AppColors.kPrimaryColor))
              ],),
            ),

          ),
          YMargin(70),
          PrimaryButtonNew(
            title: "Share your Code",
            onTap: (){},
          ),
          Spacer(),
        ],),
      ),
    );
  }
}
