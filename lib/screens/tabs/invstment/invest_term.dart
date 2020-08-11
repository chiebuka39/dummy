import 'dart:math';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/models/investment/fixed_models.dart';
import 'package:zimvest/data/models/investment/term_instruments.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/widgets/account_widgets.dart';
import 'package:zimvest/widgets/appbars.dart';
import 'package:zimvest/widgets/buttons.dart';
final naira = "Zimvest High yield (Naira)";
final dollar = "Zimvest High yield (Dollar)";


class InvestInTermScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => InvestInTermScreen(),
        settings: RouteSettings(name: InvestInTermScreen().toStringShort()));
  }
  @override
  _InvestInTermScreenState createState() => _InvestInTermScreenState();
}

class _InvestInTermScreenState extends State<InvestInTermScreen> with AfterLayoutMixin<InvestInTermScreen> {

  String _type = naira;
  bool _showOthers = false;

  //view models
  ABSInvestmentViewModel investmentViewModel;
  ABSIdentityViewModel identityViewModel;

  List<TermInstrument> nairaInstrument;
  List<TermInstrument> dollarInstrument;


  int selected;

  @override
  void afterFirstLayout(BuildContext context)async {
    await _fetchNairaInstrument();
  }

  @override
  Widget build(BuildContext context) {
    investmentViewModel = Provider.of(context);
    identityViewModel = Provider.of(context);

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
              items: [
                naira,
                dollar,
              ],
              onSelect: (value){
                if(_type == value){
                  return;
                }
                if(value == naira){
                  _fetchNairaInstrument();
                }else{
                    _fetchDollarInstruments();
                }
                setState(() {
                  _type = value;
                });
              },
              textColor: AppColors.kPrimaryColor,source: naira,),
          ),
          _buildFunds(),
          YMargin(20),
         _showOthers == false ? SizedBox(): Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AmountWidgetBorder(textColor: AppColors.kAccountTextColor,
              onChange: (value){},title: "How much are you willing to invest",),
          ),

          _showOthers == false ? SizedBox():Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: DropdownBorderInputWidget(title: "Select Investment Source",
              items: ["Card Ending in 3456", "Bank Transfer"],textColor: AppColors.kPrimaryColor,),
          ),
          YMargin(40),
          _showOthers == false ? SizedBox():PrimaryButton(
            title: 'Make Payment',
            horizontalMargin: 20,
            onPressed: (){},
          )
        ],),
      )
    );
  }

  Future _fetchNairaInstrument() async {
    EasyLoading.show(status: 'loading...');
    setState(() {
      _showOthers = false;
    });
    var result = await investmentViewModel.getNairaTermInstruments(
        token: identityViewModel.user.token);
    if(result.error == false){

      setState(() {
        nairaInstrument = result.data;
        if(nairaInstrument.isEmpty){
          _showOthers = false;
        }else{
          _showOthers = true;
        }
      });
      EasyLoading.showSuccess("Success");
    }else{
      setState(() {
        _showOthers = false;
      });
      EasyLoading.showError("error");
    }
  }
  Future _fetchDollarInstruments() async {
    EasyLoading.show(status: 'loading...');
    setState(() {
      _showOthers = false;
    });
    var result = await investmentViewModel.getDollarTermInstruments(
        token: identityViewModel.user.token);
    if(result.error == false){
      setState(() {
        dollarInstrument = result.data;
        if(dollarInstrument.isEmpty){
          _showOthers = false;
        }else{
          _showOthers = true;
        }
      });
      EasyLoading.showSuccess("Success");
    }else{
      setState(() {
        _showOthers = false;
      });
      EasyLoading.showError("error");
    }
  }


  Widget _buildFunds() {
    Widget result;
    if(_type == naira){

      if(nairaInstrument == null){
        result =  Container(
          height: 120,);
      }else{
        result = Container(
            height: 120,
            child: ListView.builder(itemBuilder: (context,index){
              return FundWidgetT(termInstrument: nairaInstrument[index],
                selected: selected == nairaInstrument[index].id,onTap: (value){
                  setState(() {
                    selected = value;
                  });
                },);
            },itemCount: nairaInstrument.length,scrollDirection: Axis.horizontal,)
        );
      }
    }else{
      if(dollarInstrument == null){
        result =  Container(
          height: 120,);
      }else{
        result = Container(
            height: 120,
            child: ListView.builder(itemBuilder: (context,index){
              return FundWidgetT(termInstrument: nairaInstrument[index],selected: selected == nairaInstrument[index].id,onTap: (value){
                setState(() {
                  selected = value;
                });
              });
            },itemCount: nairaInstrument.length,scrollDirection: Axis.horizontal,)
        );
      }
    }


    return result;
  }
}

class FundWidgetT extends StatelessWidget {
  final TermInstrument termInstrument;
  final bool selected;
  final ValueChanged<int> onTap;
  const FundWidgetT({
    Key key, this.termInstrument, this.selected, this.onTap,
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
          Text(termInstrument.instrumentName,
            style: TextStyle(fontSize: 15,
                fontFamily: "Caros-Bold", color: AppColors.kWhite),),
          Row(
            children: [
              Text(termInstrument.maturityDate,
                style: TextStyle(fontSize: 12,
                    fontFamily: "Caros", color: AppColors.kLightText),),
              Spacer(),
              Text(termInstrument.depositRate,
                style: TextStyle(fontSize: 12,
                    fontFamily: "Caros-Bold", color: AppColors.kWhite),),
            ],
          )
        ],
      ),
    );
  }
}
