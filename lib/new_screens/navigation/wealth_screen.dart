import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/savings_view_model.dart';
import 'package:zimvest/new_screens/navigation/investments/fixed/fixed_income_screen.dart';
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
          showInvest ?Expanded(child: Column(children: [
            ActionBoxWidget(title: "Zimvest High Yield", desc: "This savings plan assists you save in a "
                "disciplined manner.",
              onTap: (){
                Navigator.push(context, InvestmentHighYieldScreen.route());
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
          ],)):Expanded(child: Column(children: [
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
          ],)),

        ],),
      ),
    );
  }
}
