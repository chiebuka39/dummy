import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/dashboard_view_model.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/charts/pie2.dart';

class NairaPortfolioBreakdownScreen extends StatefulWidget {

  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => NairaPortfolioBreakdownScreen(),
        settings:
        RouteSettings(name: NairaPortfolioBreakdownScreen().toStringShort()));
  }

  @override
  _NairaPortfolioBreakdownScreenState createState() => _NairaPortfolioBreakdownScreenState();
}

class _NairaPortfolioBreakdownScreenState extends State<NairaPortfolioBreakdownScreen> {

  ABSDashboardViewModel dashboardViewModel;
  ABSIdentityViewModel identityViewModel;

  @override
  Widget build(BuildContext context) {
    dashboardViewModel = Provider.of(context);
    identityViewModel = Provider.of(context);
    print("lll;;; ${dashboardViewModel.dashboardModel.nairaPortfolio}");
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded,size: 17,color: AppColors.kPrimaryColor,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        title: Text("Portfolio Breakdown",
          style: TextStyle(color: Colors.black87,fontSize: 14, fontFamily: AppStrings.fontMedium),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(children: [
            PieChartSample2(
              value: dashboardViewModel.dashboardModel.nairaPortfolio == "0.01"? "N50,000.00":dashboardViewModel.dashboardModel.nairaPortfolio ,
              savingsValue: dashboardViewModel.portfolioDistribution == null ?40.0: dashboardViewModel.portfolioDistribution.where((element)
              => element.portfolioName == "Savings").isNotEmpty ? dashboardViewModel.portfolioDistribution.where((element)
              => element.portfolioName == "Savings").first.percentageShare : 20.0,
              investmentValue: dashboardViewModel.portfolioDistribution == null ? 20.0: dashboardViewModel.portfolioDistribution.where((element)
              => element.portfolioName == "Investment").isNotEmpty ? dashboardViewModel.portfolioDistribution.where((element)
              => element.portfolioName == "Investment").first.percentageShare : 20.0,
              walletValue: 0.0,
            ),
            YMargin(20),
            Divider(),
            Container(
              height: 70,
              child: Row(children: [
                Text("Portfolio Value", style: TextStyle(color: AppColors.kSecondaryText),),
                Spacer(),
                Text("${dashboardViewModel.dashboardModel.nairaPortfolio}", style: TextStyle(
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
                Text("Wallet balance", style: TextStyle(color: AppColors.kSecondaryText),),
                Spacer(),
                Text("${AppStrings.nairaSymbol}${FlutterMoneyFormatter(
                    amount: 31700
                ).output.nonSymbol}", style: TextStyle(
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
                Text("Investment Balance", style: TextStyle(color: AppColors.kSecondaryText),),
                Spacer(),
                Text("${AppStrings.nairaSymbol}${FlutterMoneyFormatter(
                    amount: 31700
                ).output.nonSymbol}", style: TextStyle(
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
                      color: AppColors.kSavingsP
                  ),
                ),
                XMargin(10),
                Text("Savings Balance", style: TextStyle(color: AppColors.kSecondaryText),),
                Spacer(),
                Text("${AppStrings.nairaSymbol}${FlutterMoneyFormatter(
                    amount: 31700
                ).output.nonSymbol}", style: TextStyle(
                    color: AppColors.kSecondaryBoldText, fontFamily: AppStrings.fontMedium),),
              ],),
            ),
            Divider(),

          ],),
        ),
      ),
    );
  }
}
