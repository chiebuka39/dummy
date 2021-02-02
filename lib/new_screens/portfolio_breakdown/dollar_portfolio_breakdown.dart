import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/dashboard_view_model.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/charts/pie2.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

class DollarPortfolioBreakdownScreen extends StatefulWidget {

  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => DollarPortfolioBreakdownScreen(),
        settings:
        RouteSettings(name: DollarPortfolioBreakdownScreen().toStringShort()));
  }

  @override
  _DollarPortfolioBreakdownScreenState createState() => _DollarPortfolioBreakdownScreenState();
}

class _DollarPortfolioBreakdownScreenState extends State<DollarPortfolioBreakdownScreen> {
  ABSDashboardViewModel dashboardViewModel;
  ABSIdentityViewModel identityViewModel;
  @override
  Widget build(BuildContext context) {
    dashboardViewModel = Provider.of(context);
    identityViewModel = Provider.of(context);
    return Scaffold(

      appBar: ZimAppBar(
        text: 'Portfolio Breakdown',
        icon:Icons.arrow_back_ios_rounded,
        callback: (){
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          PieChartSample2(
            dollar: true,

            value: dashboardViewModel.dashboardModel.dollarPortfolio == "\$0.01"? "\$50,000.00":getDoubleValue(dashboardViewModel.dashboardModel.dollarPortfolio) ,
            savingsValue: 0.0,
            // investmentValue:100.0,
            investmentValue: dashboardViewModel.dashboardModel.dollarInvestmentPercent.isNaN ? 100.0 : dashboardViewModel.dashboardModel.dollarInvestmentPercent,
            // walletValue: 100.0,
            walletValue: dashboardViewModel.dashboardModel.dollarWalletPercent.isNaN ? 100.0:dashboardViewModel.dashboardModel.dollarWalletPercent,
          ),
          YMargin(20),
          Divider(),
          Container(
            height: 70,
            child: Row(children: [
              Text("Portfolio Value", style: TextStyle(color: AppColors.kSecondaryText, fontFamily: AppStrings.fontNormal),),
              Spacer(),
              Text(getDoubleValue(dashboardViewModel.dashboardModel.dollarPortfolio), style: TextStyle(
                  color: AppColors.kSecondaryBoldText, fontFamily: AppStrings.fontMedium),),
            ],),
          ),
          Divider(),
          Container(
            height: 70,
            child: Row(children: [
              Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                    color: AppColors.kYellow
                ),
              ),
              XMargin(10),
              Text("Wallet balance", style: TextStyle(color: AppColors.kSecondaryText, fontFamily: AppStrings.fontNormal),),
              Spacer(),
              Text(getDoubleValue(dashboardViewModel.dashboardModel.dollarWallet), style: TextStyle(
                  color: AppColors.kSecondaryBoldText, fontFamily: AppStrings.fontMedium),),
            ],),
          ),
          Divider(),
          Container(
            height: 70,
            child: Row(children: [
              Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                    color: AppColors.kInvestmentP
                ),
              ),
              XMargin(10),
              Text("Investment Balance", style: TextStyle(color: AppColors.kSecondaryText, fontFamily: AppStrings.fontNormal),),
              Spacer(),
              Text(getDoubleValue(dashboardViewModel.dashboardModel.dollarInvestment), style: TextStyle(
                  color: AppColors.kSecondaryBoldText, fontFamily: AppStrings.fontMedium),),
            ],),
          ),
          Divider(),


        ],),
      ),
    );
  }

  String getDoubleValue(String value){
    if(value == "0.00"){
      return "\$0.00";
    }else{
      return value;
    }

  }
}
