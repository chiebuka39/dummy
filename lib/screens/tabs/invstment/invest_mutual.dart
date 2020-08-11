import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/models/investment/money_market_fund.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
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

class _InvestInMutualScreenState extends State<InvestInMutualScreen> 
    with AfterLayoutMixin<InvestInMutualScreen> {
  
  String mutualType = "Money Market Fund";
  List<MutualFund> moneyMarketFund;
  List<MutualFund> dollarFund;
  int selected;

  //view models
  ABSInvestmentViewModel investmentViewModel;
  ABSIdentityViewModel identityViewModel;
  
  @override
  void afterFirstLayout(BuildContext context)async {
    await _fetchMoneyMarketFunds();

  }

  Future _fetchMoneyMarketFunds() async {
    EasyLoading.show(status: 'loading...');
    var result = await investmentViewModel.getMoneyMarketFund(
        token: identityViewModel.user.token);
    if(result.error == false){
      setState(() {
        moneyMarketFund = result.data;
      });
      EasyLoading.showSuccess("Success");
    }else{
      EasyLoading.showError("error");
    }
  }
  Future _fetchDollarFunds() async {
    EasyLoading.show(status: 'loading...');
    var result = await investmentViewModel.getDollarFund(
        token: identityViewModel.user.token);
    if(result.error == false){
      setState(() {
        dollarFund = result.data;
      });
      EasyLoading.showSuccess("Success");
    }else{
      EasyLoading.showError("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    investmentViewModel = Provider.of(context);
    identityViewModel = Provider.of(context);
    return Scaffold(
      backgroundColor: Color(0xFFF8FBFB),
      appBar: ZimAppBar(title: "Invest in mutual funds",),
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
            child: DropdownBorderInputWidget(title: "What type of fund",
              onSelect: (value){
                if(mutualType != value){
                  if(value == "Money Market Fund"){
                    _fetchMoneyMarketFunds();
                  }else{
                    _fetchDollarFunds();
                  }
                }
                setState(() {
                  mutualType = value;
                  selected = null;
                });

              },
              source: "Money Market Fund",
              items: ["Money Market Fund", "Dollar Opportunity fund"],textColor: AppColors.kPrimaryColor,),
          ),
          _buildFunds(),
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

  Widget _buildFunds() {
    Widget result;
    if(mutualType == "Money Market Fund"){
      if(moneyMarketFund == null){
        result =  Container(
          height: 120,);
      }else{
        result = Container(
            height: 120,
            child: ListView.builder(itemBuilder: (context,index){
              return FundWidget(fund: moneyMarketFund[index],
                selected: selected == moneyMarketFund[index].id,onTap: (value){
                setState(() {
                  selected = value;
                });
                },);
            },itemCount: moneyMarketFund.length,scrollDirection: Axis.horizontal,)
        );
      }
    }else{
      if(dollarFund == null){
        result =  Container(
          height: 120,);
      }else{
        result = Container(
            height: 120,
            child: ListView.builder(itemBuilder: (context,index){
              return FundWidget(fund: dollarFund[index],selected: selected == dollarFund[index].id,onTap: (value){
                setState(() {
                  selected = value;
                });
              });
            },itemCount: dollarFund.length,scrollDirection: Axis.horizontal,)
        );
      }
    }


    return result;
  }
}

class FundWidget extends StatelessWidget {
  final MutualFund fund;
  final bool selected;
  final ValueChanged<int> onTap;
  const FundWidget({
    Key key, this.fund, this.selected = false, this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap(fund.id);
      },
      child: Container(
        height: 120,
        margin: EdgeInsets.only(left: 20),
        padding: EdgeInsets.only(left: 15,top: 20, bottom: 20, right: 15),
        width: MediaQuery.of(context).size.width - 50,
        decoration: BoxDecoration(
          color: AppColors.kPrimaryColor,
          borderRadius:BorderRadius.circular(5)
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(fund.title,
                  style: TextStyle(fontSize: 15,
                      fontFamily: "Caros-Bold", color: AppColors.kWhite),),
                Row(
                  children: [
                    Text(fund.fundName,
                      style: TextStyle(fontSize: 12,
                          fontFamily: "Caros", color: AppColors.kLightText),),
                    Spacer(),
                    Text(fund.yieldRate,
                      style: TextStyle(fontSize: 12,
                          fontFamily: "Caros-Bold", color: AppColors.kWhite),),
                  ],
                )
              ],
            ),
            Positioned(
              right: 0,
                top: -10,
                child: AnimatedOpacity(opacity: selected ? 1:0,
                duration: Duration(milliseconds: 300),
                child: Icon(Icons.check, color: AppColors.kLightText,)))
          ],
        ),
      ),
    );
  }
}
