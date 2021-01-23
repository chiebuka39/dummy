import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/models/dashboard.dart';
import 'package:zimvest/data/view_models/dashboard_view_model.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/charts/pie2.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

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
      appBar: ZimAppBar(
        text: 'Portfolio Breakdown',
        icon:Icons.arrow_back_ios_rounded,
        callback: (){
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(children: [
            PieChartSample2(
              value: dashboardViewModel.dashboardModel.nairaPortfolio == "0.01"? "N50,000.00":dashboardViewModel.dashboardModel.nairaPortfolio ,
              savingsValue: DashboardModel.savingSum(dashboardViewModel.dashboardModel) == 0.0 ?50.0: dashboardViewModel.dashboardModel.nairaSavingPercent ,
              investmentValue:DashboardModel.savingSum(dashboardViewModel.dashboardModel) == 0.0 ?50.0: dashboardViewModel.dashboardModel.nairaInvestmentPercent,
              walletValue:DashboardModel.savingSum(dashboardViewModel.dashboardModel) == 0.0 ?50.0: dashboardViewModel.dashboardModel.nairaWalletPercent,
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
                Row(
                  children: [
                    Text(dashboardViewModel.dashboardModel.nairaWallet == "0.00" ?AppStrings.nairaSymbol:'', style: TextStyle(fontSize: 12),),
                    Text(getDoubleValue(dashboardViewModel.dashboardModel.nairaWallet), style: TextStyle(
                        color: AppColors.kSecondaryBoldText, fontFamily: AppStrings.fontMedium),),
                  ],
                ),
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
                Row(
                  children: [
                    Text(dashboardViewModel.dashboardModel.nairaInvestment == "0.00" ?AppStrings.nairaSymbol:'', style: TextStyle(fontSize: 12),),
                    Text(getDoubleValue(dashboardViewModel.dashboardModel.nairaInvestment), style: TextStyle(
                        color: AppColors.kSecondaryBoldText, fontFamily: AppStrings.fontMedium),),
                  ],
                ),
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
                Row(
                  children: [
                    Text(dashboardViewModel.dashboardModel.nairaSavings == "0.00" ?AppStrings.nairaSymbol:'', style: TextStyle(fontSize: 12),),
                    Text(getDoubleValue(dashboardViewModel.dashboardModel.nairaSavings), style: TextStyle(
                        color: AppColors.kSecondaryBoldText, fontFamily: AppStrings.fontMedium),),
                  ],
                ),
              ],),
            ),
            Divider(),

          ],),
        ),
      ),
    );
  }
  String getDoubleValue(String value){
    if(value == "0.00"){
      return " 0.00";
    }else{
      return value;
    }

  }
}
