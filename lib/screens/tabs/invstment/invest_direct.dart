import 'dart:math';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/models/investment/fixed_models.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/widgets/account_widgets.dart';
import 'package:zimvest/widgets/appbars.dart';
import 'package:zimvest/widgets/buttons.dart';
final treasuryBill1 = "Treasury Bill";
final euroBond1 = "Euro Bond";
final corporateBond1 = "Corporate Bond";
final commercialPaper1 = "Commercial Paper";
final promissoryNote1 = "Promissory Note";
final FGNBond1 = "FGN Bond";

class InvestInDirectScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => InvestInDirectScreen(),
        settings: RouteSettings(name: InvestInDirectScreen().toStringShort()));
  }
  @override
  _InvestInDirectScreenState createState() => _InvestInDirectScreenState();
}

class _InvestInDirectScreenState extends State<InvestInDirectScreen> with AfterLayoutMixin<InvestInDirectScreen> {

  String _type = treasuryBill1;
  bool _showOthers = false;

  //view models
  ABSInvestmentViewModel investmentViewModel;
  ABSIdentityViewModel identityViewModel;

  List<TreasuryBill> treasuryBill;
  List<PromissoryNote> promissoryNote;
  List<FGNBond> fgnBond;
  List<CommercialPaper> commercialPaper;
  List<CorporateBond> corporateBond;
  List<EuroBond> euroBond;

  int selected;

  @override
  void afterFirstLayout(BuildContext context)async {
    await _fetchTreasuryBills();
  }

  @override
  Widget build(BuildContext context) {
    investmentViewModel = Provider.of(context);
    identityViewModel = Provider.of(context);

    return Scaffold(
      backgroundColor: Color(0xFFF8FBFB),
      appBar: ZimAppBar(title: "Invest in Direct fixed income",),
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
                treasuryBill1,
                FGNBond1,
                commercialPaper1,
                corporateBond1,
                euroBond1,
                promissoryNote1
              ],
              onSelect: (value){
                if(_type == value){
                  return;
                }
                if(value == treasuryBill1){
                  _fetchTreasuryBills();
                }else if(value == promissoryNote1){
                  _fetchPromissoryNote();
                }else if(value == commercialPaper1){
                  _fetchCommercialPaper();
                }else if(value == corporateBond1){
                  _fetchCorporateBonds();
                }else if(value == euroBond1){
                  _fetchEuroBond();
                }else{
                    _fetchFGNBonds();
                }
                setState(() {
                  _type = value;
                });
              },
              textColor: AppColors.kPrimaryColor,source: treasuryBill1,),
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

  Future _fetchTreasuryBills() async {
    EasyLoading.show(status: 'loading...');
    setState(() {
      _showOthers = false;
    });
    var result = await investmentViewModel.getTreasuryBill(
        token: identityViewModel.user.token);
    if(result.error == false){

      setState(() {
        treasuryBill = result.data;
        if(treasuryBill.isEmpty){
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
  Future _fetchPromissoryNote() async {
    EasyLoading.show(status: 'loading...');
    setState(() {
      _showOthers = false;
    });
    var result = await investmentViewModel.getPromissoryNotes(
        token: identityViewModel.user.token);
    if(result.error == false){
      setState(() {
        promissoryNote = result.data;
        if(promissoryNote.isEmpty){
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
  Future _fetchCorporateBonds() async {
    EasyLoading.show(status: 'loading...');
    setState(() {
      _showOthers = false;
    });
    var result = await investmentViewModel.getCorporateBond(
        token: identityViewModel.user.token);
    if(result.error == false){
      setState(() {
        corporateBond = result.data;
        if(corporateBond.isEmpty){
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
  Future _fetchFGNBonds() async {
    EasyLoading.show(status: 'loading...');
    setState(() {
      _showOthers = false;
    });
    var result = await investmentViewModel.getFGNBond(
        token: identityViewModel.user.token);
    if(result.error == false){
      setState(() {
        fgnBond = result.data;
        if(fgnBond.isEmpty){
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
  Future _fetchCommercialPaper() async {
    EasyLoading.show(status: 'loading...');
    setState(() {
      _showOthers = false;
    });
    var result = await investmentViewModel.getCommercialPaper(
        token: identityViewModel.user.token);
    if(result.error == false){
      setState(() {
        commercialPaper = result.data;
        if(commercialPaper.isEmpty){
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
  Future _fetchEuroBond() async {
    EasyLoading.show(status: 'loading...');
    setState(() {
      _showOthers = false;
    });
    var result = await investmentViewModel.getEuroBond(
        token: identityViewModel.user.token);
    if(result.error == false){
      setState(() {
        euroBond = result.data;
        if(euroBond.isEmpty){
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
    if(_type == treasuryBill1){

      if(treasuryBill == null){
        result =  Container(
          height: 120,);
      }else{
        result = Container(
            height: 120,
            child: ListView.builder(itemBuilder: (context,index){
              return FundWidgetT(treasuryBill: treasuryBill[index],
                selected: selected == treasuryBill[index].id,onTap: (value){
                  setState(() {
                    selected = value;
                  });
                },);
            },itemCount: treasuryBill.length,scrollDirection: Axis.horizontal,)
        );
      }
    }else if(_type == "Commercial Paper"){
      if(commercialPaper == null){
        result =  Container(
          height: 120,);
      }else{
        result = Container(
            height: 120,
            child: ListView.builder(itemBuilder: (context,index){
              return FundWidgetCom(commercialPaper: commercialPaper[index],selected: selected == commercialPaper[index].id,onTap: (value){
                setState(() {
                  selected = value;
                });
              });
            },itemCount: commercialPaper.length,scrollDirection: Axis.horizontal,)
        );
      }
    } else if(_type == "FGN Bond"){
      if(fgnBond == null){
        result =  Container(
          height: 120,);
      }else{
        result = Container(
            height: 120,
            child: ListView.builder(itemBuilder: (context,index){
              return FundWidgetFGN(fgnBond: fgnBond[index],selected: selected == fgnBond[index].id,onTap: (value){
                setState(() {
                  selected = value;
                });
              });
            },itemCount: fgnBond.length,scrollDirection: Axis.horizontal,)
        );
      }
    }else if(_type == "Promissory Note"){
      if(promissoryNote == null){
        result =  Container(
          height: 120,);
      }else{
        result = Container(
            height: 120,
            child: ListView.builder(itemBuilder: (context,index){
              return FundWidgetPro(promissoryNote: promissoryNote[index],selected: selected == promissoryNote[index].id,onTap: (value){
                setState(() {
                  selected = value;
                });
              });
            },itemCount: promissoryNote.length,scrollDirection: Axis.horizontal,)
        );
      }
    }else if(_type == "Corporate Bond"){
      if(corporateBond == null){
        result =  Container(
          height: 120,);
      }else{
        result = Container(
            height: 120,
            child: ListView.builder(itemBuilder: (context,index){
              return FundWidgetCor(corporateBond: corporateBond[index],selected: selected == corporateBond[index].id,onTap: (value){
                setState(() {
                  selected = value;
                });
              });
            },itemCount: corporateBond.length,scrollDirection: Axis.horizontal,)
        );
      }
    }else{
      if(euroBond == null){
        result =  Container(
          height: 120,);
      }else{
        result = Container(
            height: 120,
            child: ListView.builder(itemBuilder: (context,index){
              return FundWidgetEuro(euroBond: euroBond[index],selected: selected == euroBond[index].id,onTap: (value){
                setState(() {
                  selected = value;
                });
              });
            },itemCount: euroBond.length,scrollDirection: Axis.horizontal,)
        );
      }
    }


    return result;
  }
}

class FundWidgetT extends StatelessWidget {
  final TreasuryBill treasuryBill;
  final bool selected;
  final ValueChanged<int> onTap;
  const FundWidgetT({
    Key key, this.treasuryBill, this.selected, this.onTap,
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
          Text(treasuryBill.treasuryBillName,
            style: TextStyle(fontSize: 15,
                fontFamily: "Caros-Bold", color: AppColors.kWhite),),
          Row(
            children: [
              Text(treasuryBill.maturityDate,
                style: TextStyle(fontSize: 12,
                    fontFamily: "Caros", color: AppColors.kLightText),),
              Spacer(),
              Text(treasuryBill.interestRate,
                style: TextStyle(fontSize: 12,
                    fontFamily: "Caros-Bold", color: AppColors.kWhite),),
            ],
          )
        ],
      ),
    );
  }
}
class FundWidgetFGN extends StatelessWidget {
  final FGNBond fgnBond;
  final bool selected;
  final ValueChanged<int> onTap;
  const FundWidgetFGN({
    Key key, this.fgnBond, this.selected = false, this.onTap,
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
          Text(fgnBond.bondName,
            style: TextStyle(fontSize: 15,
                fontFamily: "Caros-Bold", color: AppColors.kWhite),),
          Row(
            children: [
              Text(fgnBond.maturityDate,
                style: TextStyle(fontSize: 12,
                    fontFamily: "Caros", color: AppColors.kLightText),),
              Spacer(),
              Text("",
                style: TextStyle(fontSize: 12,
                    fontFamily: "Caros-Bold", color: AppColors.kWhite),),
            ],
          )
        ],
      ),
    );
  }
}
class FundWidgetCor extends StatelessWidget {
  final CorporateBond corporateBond;
  final bool selected;
  final ValueChanged<int> onTap;
  const FundWidgetCor({
    Key key, this.corporateBond, this.selected = false, this.onTap,
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
          Text(corporateBond.corporateBondName,
            style: TextStyle(fontSize: 15,
                fontFamily: "Caros-Bold", color: AppColors.kWhite),),
          Row(
            children: [
              Text(corporateBond.maturityDate,
                style: TextStyle(fontSize: 12,
                    fontFamily: "Caros", color: AppColors.kLightText),),
              Spacer(),
              Text("",
                style: TextStyle(fontSize: 12,
                    fontFamily: "Caros-Bold", color: AppColors.kWhite),),
            ],
          )
        ],
      ),
    );
  }
}
class FundWidgetCom extends StatelessWidget {
  final CommercialPaper commercialPaper;
  final bool selected;
  final ValueChanged<int> onTap;
  const FundWidgetCom({
    Key key, this.commercialPaper, this.selected = false, this.onTap,
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
          Text(commercialPaper.commercialPaperName,
            style: TextStyle(fontSize: 15,
                fontFamily: "Caros-Bold", color: AppColors.kWhite),),
          Row(
            children: [
              Text(commercialPaper.maturityDate,
                style: TextStyle(fontSize: 12,
                    fontFamily: "Caros", color: AppColors.kLightText),),
              Spacer(),
              Text(commercialPaper.yieldRate,
                style: TextStyle(fontSize: 12,
                    fontFamily: "Caros-Bold", color: AppColors.kWhite),),
            ],
          )
        ],
      ),
    );
  }
}
class FundWidgetEuro extends StatelessWidget {
  final EuroBond euroBond;
  final bool selected;
  final ValueChanged<int> onTap;
  const FundWidgetEuro({
    Key key, this.euroBond, this.selected = false, this.onTap,
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
          Text(euroBond.euroBondName,
            style: TextStyle(fontSize: 15,
                fontFamily: "Caros-Bold", color: AppColors.kWhite),),
          Row(
            children: [
              Text(euroBond.couponRate,
                style: TextStyle(fontSize: 12,
                    fontFamily: "Caros", color: AppColors.kLightText),),
              Spacer(),
              Text("",
                style: TextStyle(fontSize: 12,
                    fontFamily: "Caros-Bold", color: AppColors.kWhite),),
            ],
          )
        ],
      ),
    );
  }
}
class FundWidgetPro extends StatelessWidget {
  final PromissoryNote promissoryNote;
  final bool selected;
  final ValueChanged<int> onTap;
  const FundWidgetPro({
    Key key, this.promissoryNote, this.selected = false, this.onTap,
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
          Text(promissoryNote.promissoryNoteName,
            style: TextStyle(fontSize: 15,
                fontFamily: "Caros-Bold", color: AppColors.kWhite),),
          Row(
            children: [
              Text(promissoryNote.maturityDate,
                style: TextStyle(fontSize: 12,
                    fontFamily: "Caros", color: AppColors.kLightText),),
              Spacer(),
              Text(promissoryNote.yieldRate,
                style: TextStyle(fontSize: 12,
                    fontFamily: "Caros-Bold", color: AppColors.kWhite),),
            ],
          )
        ],
      ),
    );
  }
}
