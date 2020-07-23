import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/widgets/account_widgets.dart';
import 'package:zimvest/widgets/appbars.dart';
import 'package:zimvest/widgets/buttons.dart';

class TargetCalculator extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => TargetCalculator(),
        settings: RouteSettings(name: TargetCalculator().toStringShort()));
  }
  @override
  _TargetCalculatorState createState() => _TargetCalculatorState();
}

class _TargetCalculatorState extends State<TargetCalculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kLightBG,
      appBar: ZimAppBar(
        title: "Target Calculator",
      ),
      body: Column(children: [
        YMargin(20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: DropdownBorderInputWidget(
            title: "How often would you like to save?",
            labelSize: 10,
            textColor: AppColors.kAccountTextColor,
            items: [
              "Monthly",
              "Weekly",
              "Quarterly"
            ],
          ),

        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: AmountWidgetBorder(
            labelSize: 10,
            title: 'How much do you want to save every?',
            textColor: AppColors.kAccountTextColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: DropdownBorderInputWidget(
            labelSize: 10,
            title: "Whats the tenure you are looking at?",
            textColor: AppColors.kAccountTextColor,
            items: [
              "1 Year",
              "6 Months",
              "2 Years"
            ],
          ),

        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextWidgetBorder(
            textColor: AppColors.kAccountTextColor,
            labelSize: 10,
            title: 'What interest rate are you hoping to get for this investment?',
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: DropdownBorderInputWidget(
            labelSize: 10,
            title: "Do you have a bulk sum saved towards this target already?",
            textColor: AppColors.kAccountTextColor,
            items: [
              "Yes",
              "No",
              "2 Years"
            ],
          ),

        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: AmountWidgetBorder(
            labelSize: 10,
            title: 'How much is the available bulk sum?',
            textColor: AppColors.kAccountTextColor,
          ),
        ),
        PrimaryButton(
          title: "Calculate",
          horizontalMargin: 20,
          onPressed: (){
            showModalBottomSheet(context: context, builder: (context){
              return Container(
                color: AppColors.kLightBG,
                padding: EdgeInsets.all(15),
                height: 370,
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SvgPicture.asset("images/round_close.svg"),
                    ],
                  ),
                  YMargin(10),
                  SvgPicture.asset("images/calc.svg"),
                  YMargin(33),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'After saving for 1 year, your investment will sum up to',
                        style: TextStyle(fontSize: 14, color: AppColors.kAccountTextColor, fontFamily: "Caros")
                      ),
                      TextSpan(
                        text: ' ₦12,000,000',
                        style: TextStyle(fontSize: 16,
                            color: AppColors.kAccountTextColor,
                            fontFamily: "Caros-Bold")
                      )
                    ]),
                  ),
                  YMargin(25),
                  Text("Would you like to go calculate "
                      "your investment goal again",style: TextStyle(
                      fontSize: 14),textAlign: TextAlign.center,),
                  Spacer(),
                  Row(children: [
                    Expanded(child: OutlinePrimaryButton(
                      borderColor: AppColors.kAccentColor,
                      title: 'Cancel',
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                    ),),
                    XMargin(24),
                    Expanded(child: PrimaryButton(
                      title: 'Yes, Please',
                      onPressed: (){},
                    ),)
                  ],),
                  YMargin(20)
                ],),
              );
            });
          },
        )
      ],),
    );
  }
}
