import 'package:after_layout/after_layout.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/animations/fab_menu_items.dart';
import 'package:zimvest/data/models/investment/investment_fixed_fund.dart';
import 'package:zimvest/data/models/investment/investment_fund_model.dart';
import 'package:zimvest/data/models/investment/investment_termed_fund.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/data/view_models/savings_view_model.dart';
import 'package:zimvest/screens/tabs/invstment/add_fund.dart';
import 'package:zimvest/screens/tabs/invstment/invest_direct.dart';
import 'package:zimvest/screens/tabs/invstment/invest_high.dart';
import 'package:zimvest/screens/tabs/invstment/invest_mutual.dart';
import 'package:zimvest/screens/tabs/invstment/invest_term.dart';
import 'package:zimvest/screens/tabs/invstment/investment_details_screen.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/styles/styles.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/enums.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/utils/validator.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/line_chart.dart';

class InvestmentScreen extends StatefulWidget {
  @override
  _InvestmentScreenState createState() => _InvestmentScreenState();
}

class _InvestmentScreenState extends State<InvestmentScreen>
    with AfterLayoutMixin<InvestmentScreen> {
  FlutterMoneyFormatter amount;
  ZimInvestmentType _zimType;
  bool showSavingsGraph = true;
  List<ZimInvestmentType> investmentList;

  //view models
  ABSInvestmentViewModel investmentViewModel;
  ABSIdentityViewModel identityViewModel;
  ABSPaymentViewModel paymentViewModel;
  ABSSavingViewModel savingViewModel;

  @override
  void initState() {
    investmentList = [
      ZimInvestmentType.MUTUAL_FUNDS,
      ZimInvestmentType.FIXED,
      ZimInvestmentType.HIGH_YIELD
    ];
    _zimType = ZimInvestmentType.MUTUAL_FUNDS;
    amount = FlutterMoneyFormatter(
        amount: 10000000, settings: MoneyFormatterSettings(fractionDigits: 0));
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    EasyLoading.show(status: 'loading...');
    var i1 = await investmentViewModel.getMutualFundValuation(
        token: identityViewModel.user.token);
    var i2 = await investmentViewModel.getFixedFundValuation(
        token: identityViewModel.user.token);
    var i3 = await investmentViewModel.getTermFundValuation(
        token: identityViewModel.user.token);
    if (i1.error == false && i2.error == false && i3.error == false) {
      var i4 = await investmentViewModel.getMutualFundActivities(
          token: identityViewModel.user.token);
      EasyLoading.dismiss();
    } else {
      EasyLoading.showError("Error");
    }
    getRequiredDetailsForForm();
  }

  void getRequiredDetailsForForm() {
    savingViewModel.getFundingChannel(token: identityViewModel.user.token);
    savingViewModel.getSavingFrequency(token: identityViewModel.user.token);
    paymentViewModel.getUserCards(identityViewModel.user.token);
    paymentViewModel.getCustomerBank(identityViewModel.user.token);
    paymentViewModel.getWallet(identityViewModel.user.token);
  }

  @override
  Widget build(BuildContext context) {
    investmentViewModel = Provider.of(context);
    paymentViewModel = Provider.of(context);
    identityViewModel = Provider.of(context);
    savingViewModel = Provider.of(context);
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 100),
        child: Fabmenuitems(
            height: 150,
            weith: 200,
            animatedIcons: AnimatedIcons.menu_close,
            fabcolor: AppColors.kAccentColor,
            containercolor: AppColors.kPrimaryColor.withOpacity(0.6),
            childrens: <Widget>[
              FabItem(
                item: "New Mutual funds",
                onTap: () {
                  Navigator.of(context).push(InvestInMutualScreen.route());
                },
              ),
              FabItem(
                  item: "New Direct Fixed income sales",
                  onTap: () {
                    Navigator.of(context).push(InvestInDirectScreen.route());
                  }),
              FabItem(
                  item: "New Zimvest yield",
                  onTap: () {
                    Navigator.of(context).push(InvestInTermScreen.route());
                  }),
            ]),
      ),
      body: Container(
        color: AppColors.kBg,
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  Row(
                    children: [
                      Spacer(),
                      CircularProfileAvatar(
                        AppStrings.avatar,
                        radius: 17,
                      ),
                      XMargin(20)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "My Investments",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Caros-Bold",
                          color: Color(0xFF0b2328)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 7),
                    child: Text(
                      "Here are the active instruments you are interested in",
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: "Caros",
                          color: Color(0xFF324d53)),
                    ),
                  ),
                  YMargin(20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        XMargin(10),
                        ZimInVestSelectedButton(
                          title: "Mutual Funds",
                          onTap: () async{
                            if(investmentViewModel.mutualFundsActivity == null){
                              EasyLoading.show(status: 'loading...');
                              await investmentViewModel.getMutualFundActivities(
                                  token: identityViewModel.user.token);
                              EasyLoading.dismiss();
                            }
                            setState(() {
                              _zimType = ZimInvestmentType.MUTUAL_FUNDS;
                            });
                          },
                          type: ZimInvestmentType.MUTUAL_FUNDS,
                          selectedType: _zimType,
                        ),
                        ZimInVestSelectedButton(
                          title: "Fixed Income",
                          onTap: () async{
                            if(investmentViewModel.fixedFundsActivity == null){
                              EasyLoading.show(status: 'loading...');
                              await investmentViewModel.getFixedFundActivities(
                                  token: identityViewModel.user.token);
                              EasyLoading.dismiss();
                            }
                            setState(() {
                              _zimType = ZimInvestmentType.FIXED;
                            });
                          },
                          type: ZimInvestmentType.FIXED,
                          selectedType: _zimType,
                        ),
                        ZimInVestSelectedButton(
                          title: "Zimvest high yield",
                          onTap: () async{
                            if(investmentViewModel.termedFundsActivity == null){
                              EasyLoading.show(status: 'loading...');
                              await investmentViewModel.getTermFundActivities(
                                  token: identityViewModel.user.token);
                              EasyLoading.dismiss();
                            }
                            setState(() {
                              _zimType = ZimInvestmentType.HIGH_YIELD;
                            });
                          },
                          type: ZimInvestmentType.HIGH_YIELD,
                          selectedType: _zimType,
                        ),
                      ],
                    ),
                  ),
                  YMargin(15),

                ]),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  _buildListOfFunds(),
                  YMargin(20),
                  _buildSavingsActivities(),
                  YMargin(20),
                ]),
              ),
              _buildActivities(),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 60,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListOfFunds() {
    Widget result;
    switch(_zimType){
      case ZimInvestmentType.MUTUAL_FUNDS:
        result = _buildMutualFundList();
        break;
      case ZimInvestmentType.FIXED:
        result = _buildFixedFundList(result);
        break;
      case ZimInvestmentType.HIGH_YIELD:
        result = _buildHighFundList(result);
        break;
    }

    return result;
  }

  Widget _buildMutualFundList() {
    if(investmentViewModel.mutualFunds == null){
      return Container(
        width: 150,
        height: 140,
        decoration: BoxDecoration(
          color: Colors.transparent
        ),
      );
    }else{
      if(investmentViewModel.mutualFunds.isEmpty){
        return NewFund(title: "New Mutual funds",);
      }else{
        return Container(
          height: 140,
          width: double.infinity,
          child: buildListView(),
        );
      }
    }
  }
  Widget _buildFixedFundList(Widget result) {
    if(investmentViewModel.fixedFunds == null){
      result = Container(
        width: 150,
        height: 140,
        decoration: BoxDecoration(
          color: Colors.transparent
        ),
      );
    }else{
      if(investmentViewModel.fixedFunds.isEmpty){
        result = NewFund(title: "New Direct fixed income funds",);
      }else{
        result = Container(
          height: 140,
          width: double.infinity,
          child: buildListView(),
        );
      }
    }
    return result;
  }
  Widget _buildHighFundList(Widget result) {
    if(investmentViewModel.termFunds == null){
      result = Container(
        width: 150,
        height: 140,
        decoration: BoxDecoration(
          color: Colors.transparent
        ),
      );
    }else{
      if(investmentViewModel.termFunds.isEmpty){
        result = NewFund(title: "New Zimvest high yield funds",);
      }else{
        result = Container(
          height: 140,
          width: double.infinity,
          child: buildListView(),
        );
      }
    }
    return result;
  }

  Widget _buildActivities() {
    Widget result;
    switch(_zimType){
      case ZimInvestmentType.MUTUAL_FUNDS:
        result = _buildMutualActivities();
        break;
      case ZimInvestmentType.FIXED:
        result = _buildFixedActivities();
        break;
      case ZimInvestmentType.HIGH_YIELD:
        result = _buildTermActivities();
        break;
    }

    return result;
  }

  Widget _buildMutualActivities() {
    Widget result;
    if(investmentViewModel.mutualFundsActivity == null){
      result =  SliverToBoxAdapter(child: SizedBox());
    }else{
      if(investmentViewModel.mutualFundsActivity.isNotEmpty){
        result = InvestementActivitiesWidget(activities: investmentViewModel.mutualFundsActivity);
      }else{
        result = SliverToBoxAdapter(
          child: Container(
            height: 100,
            child: Center(
              child: Text("You don't have any activity yet"),
            ),
          ),
        );
      }
    }
   return result;
  }
  Widget _buildFixedActivities() {
    Widget result;
    if(investmentViewModel.fixedFundsActivity == null){
      result =  SliverToBoxAdapter(child: SizedBox());
    }else{
      if(investmentViewModel.fixedFundsActivity.isNotEmpty){
        result = InvestementActivitiesWidget(activities: investmentViewModel.fixedFundsActivity);
      }else{
        result = SliverToBoxAdapter(
          child: Container(
            height: 100,
            child: Center(
              child: Text("You don't have any activity yet"),
            ),
          ),
        );
      }
    }
   return result;
  }
  Widget _buildTermActivities() {
    Widget result;
    if(investmentViewModel.termedFundsActivity == null){
      result =  SliverToBoxAdapter(child: SizedBox());
    }else{
      if(investmentViewModel.termedFundsActivity.isNotEmpty){
        result = InvestementActivitiesWidget(activities: investmentViewModel.termedFundsActivity);
      }else{
        result = SliverToBoxAdapter(
          child: Container(
            height: 100,
            child: Center(
              child: Text("You don't have any activity yet"),
            ),
          ),
        );
      }
    }
   return result;
  }

  Widget buildListView() {
    Widget list;
    switch (_zimType) {
      case ZimInvestmentType.MUTUAL_FUNDS:
        list = ListView(
          scrollDirection: Axis.horizontal,
          children: investmentViewModel.mutualFunds.map((e) {
            print("kkkk ${e.fundName}");
            return  InvestmentDetailContainer(
              amount: amount,
              mutualFund: e,
              investmentType: ZimInvestmentType.MUTUAL_FUNDS,
            );
          }).toList(),
        );
        break;
      case ZimInvestmentType.FIXED:
        list = ListView(
          scrollDirection: Axis.horizontal,
          children: investmentViewModel.fixedFunds.map((e) {
            return  InvestmentDetailContainerFixed(
              amount: amount,
              mutualFund: e,
              investmentType: ZimInvestmentType.FIXED,
            );
          }).toList(),
        );
        break;
      case ZimInvestmentType.HIGH_YIELD:
        list = ListView(
          scrollDirection: Axis.horizontal,
          children:investmentViewModel.termFunds.map((e) {
            return  InvestmentDetailContainerTerm(
              amount: amount,
              mutualFund: e,
              investmentType: ZimInvestmentType.HIGH_YIELD,
            );
          }).toList(),
        );
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

class InvestementActivitiesWidget extends StatelessWidget {
  const InvestementActivitiesWidget({
    Key key,
    @required this.activities,
  }) : super(key: key);

  final List<InvestmentActivity> activities;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(List.generate(
          activities.length > 7 ?
          7:activities.length,
              (index) {
            InvestmentActivity activity = activities[index];
            return Container(
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
                        activity.description,
                        style: TextStyle(
                            color: Color(0xFF324d53), fontSize: 12),
                      ),
                      YMargin(5),
                      Text(
                        activity.date,
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
                        activity?.amount ?? activity.interestAmount,
                        style: TextStyle(
                            fontSize: 12, color: AppColors.kGreen),
                      ),
                      YMargin(5),
                      Text(
                        statusValues.reverse[activity.status],
                        style: TextStyle(
                            fontSize: 10,
                            color: AppColors.kLightText2),
                      )
                    ],
                  )
                ],
              ),
            );
              })),
    );
  }
}

class NewFund extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const NewFund({
    Key key, this.title, this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            margin: EdgeInsets.only(left: 20),
            width: 150,
            height: 140,
            decoration: BoxDecoration(
                color: AppColors.kPrimaryColor,
              borderRadius: BorderRadius.circular(6)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle
                ),
                child: Center(child: Icon(Icons.add, color: AppColors.kAccentColor,),),
              ),

              SizedBox(
                width: 100,
                child: Text(title, style: TextStyle(
                  fontSize: 12,color: AppColors.kAccentColor
                ),textAlign: TextAlign.center,),
              )
            ],),
          ),
        ),
      ],
    );
  }
}

class FabItem extends StatelessWidget {
  final String item;
  final Function onTap;
  const FabItem({
    Key key,
    this.item,
    this.onTap,
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
  final double width;
  const SavingsActionWidget({
    Key key,
    this.title,
    this.onTap,
    this.icon = "savings", this.width = 120,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        width: width,
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
    @required this.amount,
    this.investmentType, this.mutualFund,
  }) : super(key: key);

  final FlutterMoneyFormatter amount;
  final ZimInvestmentType investmentType;
  final InvestmentMutualFund mutualFund;

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
                        style: TextStyle(
                            fontSize: 10,
                            color: AppColors.kWhite,
                            fontFamily: "Caros-Medium"),
                      ),
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(InvestmentDetailScreen.route(id: mutualFund.fundId,title: mutualFund.fundName));
                    },
                    child: SizedBox(
                      width: 85,
                      child: Row(
                        children: [
                          Text(
                            "View details",
                            style: TextStyle(
                                fontSize: 10, color: AppColors.kAccentColor),
                          ),
                          Icon(
                            Icons.navigate_next,
                            color: AppColors.kAccentColor,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              YMargin(10),
              Text(
                mutualFund.fundName,
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
                    mutualFund.currentValue,
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
                  "${mutualFund.percentageInterest} Interest P.A",
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
    switch (investmentType) {
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
class InvestmentDetailContainerFixed extends StatelessWidget {
  const InvestmentDetailContainerFixed({
    Key key,
    @required this.amount,
    this.investmentType, this.mutualFund,
  }) : super(key: key);

  final FlutterMoneyFormatter amount;
  final ZimInvestmentType investmentType;
  final InvestmentFixedFund mutualFund;

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
                        style: TextStyle(
                            fontSize: 10,
                            color: AppColors.kWhite,
                            fontFamily: "Caros-Medium"),
                      ),
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(InvestmentDetailScreen.route(id: mutualFund.fixedIncomeId,
                        title: mutualFund.fixedIncomeName,type:"fixed"));
                    },
                    child: SizedBox(
                      width: 85,
                      child: Row(
                        children: [
                          Text(
                            "View details",
                            style: TextStyle(
                                fontSize: 10, color: AppColors.kAccentColor),
                          ),
                          Icon(
                            Icons.navigate_next,
                            color: AppColors.kAccentColor,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              YMargin(10),
              Text(
                mutualFund.fixedIncomeName,
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
                    mutualFund.currentValue,
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
                  "${mutualFund.percentageInterest} Interest P.A",
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
    switch (investmentType) {
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
class InvestmentDetailContainerTerm extends StatelessWidget {
  const InvestmentDetailContainerTerm({
    Key key,
    @required this.amount,
    this.investmentType, this.mutualFund,
  }) : super(key: key);

  final FlutterMoneyFormatter amount;
  final ZimInvestmentType investmentType;
  final InvestmentTermFund mutualFund;

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
                        style: TextStyle(
                            fontSize: 10,
                            color: AppColors.kWhite,
                            fontFamily: "Caros-Medium"),
                      ),
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(InvestmentDetailScreen.route(id: mutualFund.termInstrumentId,
                          title: mutualFund.termInstrumentName,type: "term"));
                    },
                    child: SizedBox(
                      width: 85,
                      child: Row(
                        children: [
                          Text(
                            "View details",
                            style: TextStyle(
                                fontSize: 10, color: AppColors.kAccentColor),
                          ),
                          Icon(
                            Icons.navigate_next,
                            color: AppColors.kAccentColor,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              YMargin(10),
              Text(
                mutualFund.termInstrumentName,
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
                    mutualFund.currentValue,
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
                  "${mutualFund.percentageInterest} Interest P.A",
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
    switch (investmentType) {
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
