import 'package:flutter/material.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/widgets/account_widgets.dart';
import 'package:zimvest/widgets/appbars.dart';
import 'package:zimvest/widgets/buttons.dart';

class InvestInHighScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => InvestInHighScreen(),
        settings: RouteSettings(name: InvestInHighScreen().toStringShort()));
  }
  @override
  _InvestInHighScreenState createState() => _InvestInHighScreenState();
}

class _InvestInHighScreenState extends State<InvestInHighScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FBFB),
      appBar: ZimAppBar(title: "Invest in Zimvest High Yield",),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: ListView(children: [
          YMargin(15),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text("Tell us how you want to structure this investment",style: TextStyle(fontSize: 10, color: AppColors.kPrimaryColor),),
          ),
          YMargin(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: DropdownBorderInputWidget(title: "What are you investing?",
              items: ["Dollar Instrument"],textColor: AppColors.kPrimaryColor,),
          ),
          Container(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                FundHighWidget(),
                FundHighWidget(),
                FundHighWidget(),
              ],
            ),
          ),
          YMargin(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AmountWidgetBorder(textColor: AppColors.kAccountTextColor,
              onChange: (value){},title: "How much are you willing to invest",),
          ),
         
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: DropdownBorderInputWidget(title: "Select Investment Source",
              items: ["Card Ending in 3456", "Bank Transfer"],textColor: AppColors.kPrimaryColor,),
          ),
          YMargin(40),
          PrimaryButton(
            title: 'Make Payment',
            horizontalMargin: 20,
            onPressed: (){},
          )
        ],),
      )
    );
  }
}

class FundHighWidget extends StatelessWidget {
  const FundHighWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: EdgeInsets.only(left: 20),
      padding: EdgeInsets.only(left: 15,top: 20, bottom: 20, right: 15),
      width: MediaQuery.of(context).size.width - 50,
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor,
        borderRadius:BorderRadius.circular(5)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("90 days 4.5%",
            style: TextStyle(fontSize: 15,
                fontFamily: "Caros-Bold", color: AppColors.kWhite),),
          Row(
            children: [
              Text("(17 April 2020)",
                style: TextStyle(fontSize: 12,
                    fontFamily: "Caros", color: AppColors.kLightText),),
              Spacer(),
              Text("Deposit rate:6.00%",
                style: TextStyle(fontSize: 12,
                    fontFamily: "Caros-Bold", color: AppColors.kWhite),),
            ],
          )
        ],
      ),
    );
  }
}
