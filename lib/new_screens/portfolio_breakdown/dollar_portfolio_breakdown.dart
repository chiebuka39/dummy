import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/charts/pie2.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded,size: 20,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        title: Text("Portfolio Breakdown",
          style: TextStyle(color: Colors.black87,fontSize: 14),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          PieChartSample2(dollar: true,),
          YMargin(20),
          Divider(),
          Container(
            height: 70,
            child: Row(children: [
              Text("Portfolio Value", style: TextStyle(color: AppColors.kGreyText),),
              Spacer(),
              Text("\$${FlutterMoneyFormatter(
                amount: 31700
              ).output.nonSymbol}", style: TextStyle(
                  color: AppColors.kGreyText, fontFamily: AppStrings.fontMedium),),
            ],),
          ),
          Divider(),
          Container(
            height: 70,
            child: Row(children: [
              Text("Wallet balance", style: TextStyle(color: AppColors.kGreyText),),
              Spacer(),
              Text("\$${FlutterMoneyFormatter(
                  amount: 31700
              ).output.nonSymbol}", style: TextStyle(
                  color: AppColors.kGreyText, fontFamily: AppStrings.fontMedium),),
            ],),
          ),
          Divider(),
          Container(
            height: 70,
            child: Row(children: [
              Text("Investment Balance", style: TextStyle(color: AppColors.kGreyText),),
              Spacer(),
              Text("\$${FlutterMoneyFormatter(
                  amount: 31700
              ).output.nonSymbol}", style: TextStyle(
                  color: AppColors.kGreyText, fontFamily: AppStrings.fontMedium),),
            ],),
          ),
          Divider(),


        ],),
      ),
    );
  }
}