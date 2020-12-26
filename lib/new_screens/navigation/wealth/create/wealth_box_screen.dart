import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zimvest/new_screens/navigation/wealth/create/automate_screen.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';

class WealthBoxScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => WealthBoxScreen(),
        settings:
        RouteSettings(name: WealthBoxScreen().toStringShort()));
  }
  @override
  _WealthBoxScreenState createState() => _WealthBoxScreenState();
}

class _WealthBoxScreenState extends State<WealthBoxScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> benefits = [
      'Earn great returns',
      'Withdraw at the first day of every quarter',
      'Save daily, weekly or monthly'
    ];
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFF49493),
      body: Column(children: [
        YMargin(30),
        Row(children: [
          IconButton(icon: Icon(Icons.close, color: AppColors.kWhite,), onPressed: (){
              Navigator.of(context).pop();
          })
        ],),
        Center(child: SvgPicture.asset("images/wealth_illus.svg",height:height > 800 ? 200 + (height - 750):  200,)),
        YMargin(20),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.kWhite,
              borderRadius: BorderRadius.only(topRight: Radius.circular(25),
                  topLeft: Radius.circular(25))
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text("Zimvest WealthBox", style: TextStyle(fontSize: 15,
                    fontFamily: AppStrings.fontBold),),
                  YMargin(20),
                  Text("Optimize your wealth with our explicit savings plan and "
                      "conveniently save your preferred amount at your chosen interval. Our Wealth Box plan "
                      "allows you to conveniently save a mimimum amount of ₦200.",
                    style: TextStyle(fontSize: 12,height: 1.8, fontFamily: AppStrings.fontLight),),
                  YMargin(30),
                  ...List.generate(benefits.length, (index) {
                    return Container(
                      height: 40,
                      child: Row(children: [
                        SvgPicture.asset("images/new/star.svg"),
                        XMargin(20),
                        Text(benefits[index], style: TextStyle(fontSize: 12),)
                      ],),
                    );
                  }),
                  YMargin( 50),
                  Center(
                    child: PrimaryButtonNew(
                      title: "Get Started",
                      onTap: (){
                        Navigator.push(context, AutomateSavingsScreen.route());
                      },
                    ),
                  ),

              ],),
            ),

          ),
        )
      ],),
    );

  }
}
