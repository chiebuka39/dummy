import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
import 'package:zimvest/data/view_models/savings_view_model.dart';
import 'package:zimvest/new_screens/navigation/investments/fixed/fixed_income_screen.dart';
import 'package:zimvest/new_screens/navigation/investments/high_yield/dollar/high_yield_investment_details_dollars.dart';
import 'package:zimvest/new_screens/navigation/investments/high_yield/naira/high_yield_investment_details_naira.dart';
import 'package:zimvest/new_screens/navigation/investments/investment_high_yield_screen.dart';
import 'package:zimvest/new_screens/navigation/wealth/aspire/aspire_box_screen.dart';
import 'package:zimvest/new_screens/navigation/wealth/create/wealth_box_screen.dart';
import 'package:zimvest/new_screens/navigation/wealth/wealth_box_details.dart';
import 'package:zimvest/new_screens/navigation/widgets/earn_free_cash.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/home/action_box_widgets.dart';

class WealthScreen extends StatefulWidget {
  @override
  _WealthScreenState createState() => _WealthScreenState();
}

class _WealthScreenState extends State<WealthScreen> {
  bool showInvest = false;

  ABSSavingViewModel savingViewModel;

  @override
  Widget build(BuildContext context) {
    savingViewModel  = Provider.of(context);
    double tabWidth = MediaQuery.of(context).size.width - 40;
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [

                Text("Wealth", style: TextStyle(fontSize: 16, fontFamily: AppStrings.fontBold),),
                Spacer(),
                EarnFreeCashWidget()
              ],
            ),
          ),
          YMargin(33),
          Row(
            children: <Widget>[
              Spacer(),
              Container(
                width: tabWidth,
                height: 40,
                decoration: BoxDecoration(
                    color: AppColors.kPrimaryColorLight,
                    borderRadius: BorderRadius.circular(13)),
                child: Stack(
                  children: <Widget>[
                    AnimatedPositioned(
                      left: showInvest == true ? tabWidth/2 : 0,
                      duration: Duration(milliseconds: 300),
                      child: Container(
                        width: tabWidth/2,
                        height: 40,
                        decoration: BoxDecoration(
                            color: AppColors.kPrimaryColor,
                            borderRadius: BorderRadius.circular(13)),
                      ),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    showInvest = false;
                                  });
                                },
                                child: Container(
                                    child: Center(
                                        child: Text(
                                          "Save",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: showInvest == false?Colors.white:AppColors.kPrimaryColor
                                          ),
                                        ))),
                              )),
                          Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    showInvest = true;
                                  });
                                },
                                child: Container(
                                    child: Center(
                                        child: Text(
                                          "Invest",
                                          style: TextStyle(fontSize: 12,
                                          color: showInvest == true?Colors.white:AppColors.kPrimaryColor),
                                        ))),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
            ],
          ),
          YMargin(30),
          showInvest ?Expanded(child: SingleChildScrollView(
            child: Column(children: [
              ActionBoxWidget(title: "Zimvest High Yield", desc: "This savings plan assists you save in a "
                  "disciplined manner.",
                onTap: (){
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => ViewModelProvider<
                        InvestmentHighYieldViewModel>.withConsumer(
                      viewModelBuilder: () => InvestmentHighYieldViewModel(),
                      builder: (context, model, _) =>  Container(
                        height: 400,
                        width: double.infinity,
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            Container(
                              height: 5,
                              width: 40,
                              decoration: BoxDecoration(
                                color: AppColors.kWhite,
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            YMargin(10),
                            Container(
                              height: 385,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.kWhite,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  YMargin(50),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Text(
                                      "Zimvest High Yield",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: AppStrings.fontNormal),
                                    ),
                                  ),
                                  YMargin(20),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: GestureDetector(
                                      onTap: () => Navigator.push(
                                        context,
                                        HighYieldDetails.route(),
                                      ),
                                      child: Container(
                                        height: 130,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: AppColors.kPrimaryColor,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Text(
                                                "Zimvest High Yield Naira",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily:
                                                      AppStrings.fontNormal,
                                                  color: AppColors.kWhite,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Container(
                                                height: 40,
                                                // width: 150,
                                                child: Text(
                                                  "Invest in our naira denominated fixed deposit product and watch you Naira grow.",
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily:
                                                        AppStrings.fontNormal,
                                                    color: AppColors.kWhite,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  YMargin(20),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: GestureDetector(
                                      onTap: () => Navigator.push(
                                        context,
                                        HighYieldDetailsDollar.route(),
                                      ),
                                      child: Container(
                                        height: 130,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: AppColors.kSecondaryColor,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Text(
                                                "Zimvest High Yield Dollar",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily:
                                                      AppStrings.fontNormal,
                                                  color: AppColors.kWhite,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Container(
                                                height: 40,
                                                // width: 150,
                                                child: Text(
                                                  "Invest in our USD denominated fixed deposit and hedge against exchange rate risk, plus appreciable returns on your dollar investment.  ",
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily:
                                                        AppStrings.fontNormal,
                                                    color: AppColors.kWhite,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                color: AppColors.kHighYield,img: 'high',),
              ActionBoxWidget(desc: "Invest in fixed income vehicles"
                "such as Treasury Bills, FGN Bonds"
                "Corporate Bonds, and Eurobonds",title: "Zimvest Fixed Income",
                color: AppColors.kFixed,img: 'fixed',
                onTap: (){
                  Navigator.push(context, FixedIncomeHome.route());
                },
              ),
              YMargin(140),
            ],),
          )):Expanded(child: SingleChildScrollView(
            child: Column(children: [
              ActionBoxWidget(title: "Zimvest wealth box", desc: "This savings plan assists you save in a "
                  "disciplined manner.", color: AppColors.kWealth,
                onTap: (){
                  if(savingViewModel.savingPlanModel == null ){
                    Navigator.push(context, WealthBoxScreen.route());
                  }
                  else if( savingViewModel.savingPlanModel.where((element) => element.productId == 1).isEmpty){
                    Navigator.push(context, WealthBoxScreen.route());
                  }else{
                    Navigator.push(context, WealthBoxDetailsScreen.route(savingViewModel.savingPlanModel
                        .where((element) => element.productId == 1).first));
                  }
                },
              ),
              ActionBoxWidget(title: "Zimvest Aspire", desc: "This savings plan assists you save in a "
                  "disciplined manner.", color: AppColors.kAspire, img: 'aspire',
                onTap: (){
                  Navigator.push(context, AspireSavingScreen.route());
                },
              ),
              YMargin(140),
            ],),
          )),

        ],),
      ),
    );
  }
}
