import 'package:flutter/material.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/widgets/account_widgets.dart';
import 'package:zimvest/widgets/appbars.dart';
import 'package:zimvest/widgets/buttons.dart';

class InvestInMutualScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => InvestInMutualScreen(),
        settings: RouteSettings(name: InvestInMutualScreen().toStringShort()));
  }
  @override
  _InvestInMutualScreenState createState() => _InvestInMutualScreenState();
}

class _InvestInMutualScreenState extends State<InvestInMutualScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FBFB),
      appBar: ZimAppBar(title: "Invest in mutual funds",),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: ListView(children: [
          YMargin(15),
          Text("Tell us how you want to structure this investment",style: TextStyle(fontSize: 10, color: AppColors.kPrimaryColor),),
          YMargin(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: DropdownBorderInputWidget(title: "What type of fund",
              items: ["Money Market Fund"],textColor: AppColors.kPrimaryColor,),
          ),
          Container(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                FundWidget(),
                FundWidget(),
                FundWidget(),
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
            child: DropdownBorderInputWidget(title: "How often will you invest",
              items: ["Monthly", "Quarterly", "Weekly"],textColor: AppColors.kPrimaryColor,),
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

class FundWidget extends StatelessWidget {
  const FundWidget({
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
          Text("Zimvest money market fund",
            style: TextStyle(fontSize: 15,
                fontFamily: "Caros-Bold", color: AppColors.kWhite),),
          Row(
            children: [
              Text("90 day average yield 90%",
                style: TextStyle(fontSize: 12,
                    fontFamily: "Caros", color: AppColors.kLightText),),
              Spacer(),
              Text("9%",
                style: TextStyle(fontSize: 12,
                    fontFamily: "Caros-Bold", color: AppColors.kWhite),),
            ],
          )
        ],
      ),
    );
  }
}
