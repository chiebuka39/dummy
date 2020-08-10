import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zimvest/animations/fab_menu_items.dart';
import 'package:zimvest/screens/tabs/invstment/add_fund.dart';
import 'package:zimvest/screens/tabs/invstment/invest_direct.dart';
import 'package:zimvest/screens/tabs/invstment/invest_high.dart';
import 'package:zimvest/screens/tabs/invstment/invest_mutual.dart';
import 'package:zimvest/screens/tabs/invstment/withdraw_fund.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/styles/styles.dart';
import 'package:zimvest/utils/enums.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/appbars.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/line_chart.dart';

class InvestmentDetailScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => InvestmentDetailScreen(),
        settings: RouteSettings(name: InvestmentDetailScreen().toStringShort()));
  }
  @override
  _InvestmentDetailScreenState createState() => _InvestmentDetailScreenState();
}

class _InvestmentDetailScreenState extends State<InvestmentDetailScreen> {
  FlutterMoneyFormatter amount;
  ZimInvestmentType _zimType;
  bool showSavingsGraph = true;
  List<ZimInvestmentType> investmentList;

  double completion = 37;


  @override
  void initState() {
    investmentList = [ZimInvestmentType.MUTUAL_FUNDS,
      ZimInvestmentType.FIXED,
      ZimInvestmentType.HIGH_YIELD];
    _zimType = ZimInvestmentType.MUTUAL_FUNDS;
    amount = FlutterMoneyFormatter(
        amount: 1000, settings: MoneyFormatterSettings(fractionDigits: 0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ZimAppBar(
        title: "Zimvest Money Market Fund",
      ),
      body: Container(
        color: AppColors.kBg,
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([

                YMargin(15),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.all(16),
                  height: 140,
                  decoration: BoxDecoration(
                    color: AppColors.kPrimaryColor,
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Row(
                      children: [
                        Text(
                          "Zimvest wealth balance",
                          style: TextStyle(fontSize: 11, color: Color(0xFFa2bdc3)),
                        ),
                        Spacer(),
                        SizedBox(
                          width: 115,
                          child: Text(
                            "Joined 25 March, 2020",
                            style: TextStyle(fontSize: 10, color: Color(0xFFa2bdc3)),
                          ),
                        ),
                      ],
                    ),
                    YMargin(5),
                    Text(
                      amount.output.symbolOnLeft,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Caros-Medium",
                          color: AppColors.kWhite),
                    ),
                      Spacer(),
                      Row(
                        children: [
                          Text("90 day average yield",
                            style: TextStyle(
                                fontSize: 10,
                                color: AppColors.kWhite),),
                          XMargin(10),
                          Text("9%",
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: "Caros-Medium",
                                color: AppColors.kWhite),),
                        ],
                      ),
                      YMargin(10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: LinearProgressIndicator(
                          minHeight: 6,
                          backgroundColor: Color(0xFFfcf8ee),
                          value: completion / 100,
                          valueColor: AlwaysStoppedAnimation<Color>(AppColors.kAccentColor),
                        ),
                      ),
                      YMargin(11),
                      Row(
                        children: [
                          Text(
                            "25 days",
                            style: TextStyle(fontSize: 8, color: AppColors.kLightTitleText),
                          ),
                          Text(
                            " /100 days",
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: "Caros-Medium",
                                color: AppColors.kWhite),
                          ),
                          Spacer(),
                          Text(
                            "${completion}% Complete",
                            style:
                            TextStyle(color: AppColors.kWhite, fontSize: 8),
                          ),
                        ],
                      )
                  ],),
                ),
                YMargin(10),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      SavingsActionWidget(
                        title: "Add funds",
                        onTap: (){
                          Navigator.of(context).push(AddFundScreen.route());
                        },
                      ),
                      XMargin(5),
                      SavingsActionWidget(
                        title: "Withdraw",
                        onTap: (){
                          Navigator.of(context).push(WithdrawFundScreen.route());
                        },
                      )
                    ],
                  ),
                ),
                YMargin(20),

                _buildSavingsActivities(),

                YMargin(20),
              ]),
            ),
            SliverList(
              delegate: SliverChildListDelegate(List.generate(
                  4,
                  (index) => Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: .5, color: AppColors.kLightText))),
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        height: 55,
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Wealth Box",
                                  style: TextStyle(
                                      color: Color(0xFF324d53), fontSize: 12),
                                ),
                                YMargin(5),
                                Text(
                                  "Mon, April 13 2020",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: AppColors.kLightText2),
                                )
                              ],
                            ),
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "450.00",
                                  style: TextStyle(
                                      fontSize: 12, color: AppColors.kGreen),
                                ),
                                YMargin(5),
                                Text(
                                  "Successful",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: AppColors.kLightText2),
                                )
                              ],
                            )
                          ],
                        ),
                      ))),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 60,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildListView() {
    Widget list;
    switch(_zimType){
      case ZimInvestmentType.MUTUAL_FUNDS:
        list = ListView(
          scrollDirection: Axis.horizontal,
          children: [
            InvestmentDetailContainer(amount: amount,investmentType: ZimInvestmentType.MUTUAL_FUNDS,),
            InvestmentDetailContainer(amount: amount,investmentType: ZimInvestmentType.MUTUAL_FUNDS,),
          ],);
        break;
      case ZimInvestmentType.FIXED:
        list = ListView(
          scrollDirection: Axis.horizontal,
          children: [
            InvestmentDetailContainer(amount: amount,investmentType: ZimInvestmentType.FIXED,),
          ],);
        break;
      case ZimInvestmentType.HIGH_YIELD:
        list = ListView(
          scrollDirection: Axis.horizontal,
          children: [
            InvestmentDetailContainer(amount: amount,investmentType: ZimInvestmentType.HIGH_YIELD,),
            InvestmentDetailContainer(amount: amount,investmentType: ZimInvestmentType.HIGH_YIELD,),
          ],);
        break;
    }
    return list;
  }

  Widget _buildTrackYourSavingsHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Track your savings",
            style: TextStyle(
                fontSize: 16,
                fontFamily: "Caros-Bold",
                color: AppColors.kPrimaryColor2),
          ),
          InkWell(
            onTap: () {
              setState(() {
                showSavingsGraph = !showSavingsGraph;
              });
            },
            child: Container(
              child: Row(
                children: [
                  Text(
                    "Hide",
                    style: TextStyle(
                        fontFamily: "Caros-Medium",
                        fontSize: 12,
                        color: AppColors.kAccentColor),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 19,
                    color: AppColors.kAccentColor,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSavingsActivities() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Investment activities",
            style: TextStyle(
                fontSize: 16,
                fontFamily: "Caros-Bold",
                color: AppColors.kPrimaryColor2),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              child: Row(
                children: [
                  Text(
                    "See all",
                    style: TextStyle(
                        fontFamily: "Caros-Medium",
                        fontSize: 12,
                        color: AppColors.kAccentColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FabItem extends StatelessWidget {
  final String item;
  final Function onTap;
  const FabItem({
    Key key, this.item, this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 2),
        alignment: Alignment.centerLeft,
        child: Row(
          children: <Widget>[
            Expanded(
                child: Text(
              item,
              style: TextStyle(
                  color: AppColors.kWhite,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ))
          ],
        ),
      ),
    );
  }
}

class PauseSavingsWidget extends StatelessWidget {
  final bool active;
  final ValueChanged<bool> onChange;
  const PauseSavingsWidget({
    Key key,
    this.active,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 45,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: AppColors.kLightText),
              bottom: BorderSide(color: AppColors.kLightText))),
      child: Row(
        children: [
          Text(
            "Pause your savings",
            style: TextStyle(color: Color(0xFF324d53)),
          ),
          Spacer(),
          Transform.scale(
            scale: 0.8,
            child: CupertinoSwitch(
              onChanged: onChange,
              value: active,
              activeColor: AppColors.kAccentColor,
            ),
          )
        ],
      ),
    );
  }
}

class SavingsActionWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final String icon;
  const SavingsActionWidget({
    Key key,
    this.title,
    this.onTap,
    this.icon = "savings",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 120,
        decoration: BoxDecoration(
            color: AppColors.kPrimaryColor,
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(
              "images/$icon.svg",
              color: AppColors.kAccentColor,
            ),
            Text(
              title,
              style: TextStyle(
                  color: AppColors.kWhite,
                  fontSize: 11,
                  fontFamily: "Caros-medium"),
            )
          ],
        ),
      ),
    );
  }
}

class InvestmentDetailContainer extends StatelessWidget {
  const InvestmentDetailContainer({
    Key key,
    @required this.amount, this.investmentType,
  }) : super(key: key);

  final FlutterMoneyFormatter amount;
  final ZimInvestmentType investmentType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      margin: EdgeInsets.only(left: 20),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      width: MediaQuery.of(context).size.width - 50,
      decoration: BoxDecoration(
          color: AppColors.kPrimaryColor,
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 20,
                    width: 100,
                    decoration: BoxDecoration(color: Color(0xFF324d53)),
                    child: Center(
                      child: Text(
                        getTitle(),
                        style: TextStyle(fontSize: 10, color: AppColors.kWhite,
                            fontFamily: "Caros-Medium"),
                      ),
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    width: 85,
                    child: Row(
                      children: [
                        Text(
                          "View details",
                          style: TextStyle(fontSize: 10, color: AppColors.kAccentColor),
                        ),
                        Icon(Icons.navigate_next, color: AppColors.kAccentColor,)
                      ],
                    ),
                  ),
                ],
              ),
              YMargin(10),
              Text(
                "A random fixed income",
                style: TextStyle(
                    color: AppColors.kLightText,
                    fontSize: 11,
                    fontFamily: "Caros"),
              ),
            ],
          ),
          Spacer(),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Maximum amount",
                    style: TextStyle(
                        fontSize: 10, color: AppColors.kLightTitleText),
                  ),
                  YMargin(3),
                  Text(
                    amount.output.symbolOnLeft,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Caros-Medium",
                        color: AppColors.kWhite),
                  )
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  "6% Interest P.A",
                  style: TextStyle(
                      color: AppColors.kWhite,
                      fontSize: 10,
                      fontFamily: "Caros-Medium"),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  String getTitle() {
    String value;
    switch (investmentType){
      case ZimInvestmentType.MUTUAL_FUNDS:
        value = "Mutual funds".toUpperCase();
        break;
      case ZimInvestmentType.FIXED:
        value = "Fixed income".toUpperCase();
        break;
      case ZimInvestmentType.HIGH_YIELD:
        value = "High Yield".toUpperCase();
        break;
    }
    return value;
  }
}
