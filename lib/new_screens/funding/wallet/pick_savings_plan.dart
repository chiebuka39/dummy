import 'package:flutter/material.dart';
import 'package:zimvest/new_screens/funding/top_up_screen.dart';
import 'package:zimvest/new_screens/funding/wallet/top_up_plan_screen.dart';
import 'package:zimvest/new_screens/navigation/portfolio/aspire_widgets.dart';
import 'package:zimvest/new_screens/navigation/wealth/wealth_box_details.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';

class PickSavingsPlanSceen extends StatefulWidget {

  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => PickSavingsPlanSceen(),
        settings: RouteSettings(name: PickSavingsPlanSceen().toStringShort()));
  }

  @override
  _PickSavingsPlanSceenState createState() => _PickSavingsPlanSceenState();
}

class _PickSavingsPlanSceenState extends State<PickSavingsPlanSceen> {
  @override
  Widget build(BuildContext context) {
    List<String> goals = ["Rent","Gift","Good Vibes","Football","Basketball"];
    List<String> goals1 = ["Rent","Gift","Good Vibes","Football","Basketball"];
    return Scaffold(

      body: CustomScrollView(

        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.navigate_before_rounded, color: AppColors.kPrimaryColor,),onPressed: (){
              Navigator.pop(context);
            },
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(delegate: SliverChildListDelegate([
              Text("Where do you want to withdraw to ?",
                style: TextStyle(fontSize: 15,fontFamily: AppStrings.fontBold),),
              YMargin(33),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, TopUpPlanScreen.route());
                },
                child: Container(
                  height: 154,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                    color: AppColors.kWhite,
                    boxShadow: AppUtils.getBoxShaddow,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      YMargin(3),
                      Text("Zimvest WealthBox"),
                      Spacer(),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Balance",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: AppStrings.fontNormal,
                                    color: AppColors.kGreyText),
                              ),
                              YMargin(10),
                              Text(
                                "${AppStrings.nairaSymbol}500,000",
                                style: TextStyle(
                                    color: AppColors.kGreyText,
                                    fontFamily: AppStrings.fontMedium),
                              )
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Interest P.A",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: AppStrings.fontNormal,
                                    color: AppColors.kGreyText),
                              ),
                              YMargin(10),
                              Text(
                                "5.5%",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: AppColors.kGreyText,
                                    fontFamily: AppStrings.fontMedium),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Text(
                      "Goals",
                      style: TextStyle(
                          fontFamily: AppStrings.fontMedium,
                          color: AppColors.kGreyText),
                    ),
                    XMargin(3),
                    Text(
                      "(Zimvest aspire)",
                      style: TextStyle(
                          fontFamily: AppStrings.fontNormal,
                          color: AppColors.kGreyText,
                          fontSize: 12),
                    ),
                  ],
                ),
              ),
            ])),
          ),
          SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(delegate: SliverChildListDelegate([
                ...List.generate((goals.length / 2).round(), (index) {
                  print("ppmm ${index} >>>> ${(goals.length / 2).round() - 1}");

                  if (goals.length.isOdd && ((goals.length / 2).round() - 1) == index) {
                    String goal = goals1.removeAt(0);
                    return Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          AspireContainerWidget(goal: goal,),
                          XMargin(20),
                          Expanded(child: SizedBox())

                        ],
                      ),
                    );
                  }
                  String goal = goals1.removeAt(0);
                  String goal1 = goals1.removeAt(0);

                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        AspireContainerWidget(goal: goal,),
                        XMargin(20),
                        AspireContainerWidget(goal: goal1,),
                      ],
                    ),
                  );
                }),
              ]),),
          )
        ],
      ),
    );
  }
}
