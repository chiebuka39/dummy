import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/models/investment/bank_payment_details.dart';
import 'package:zimvest/data/models/investment/money_market_fund.dart';
import 'package:zimvest/data/models/savings/funding_channels.dart';
import 'package:zimvest/data/models/savings/savings_frequency.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/data/view_models/savings_view_model.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/widgets/account_widgets.dart';
import 'package:zimvest/widgets/appbars.dart';
import 'package:zimvest/widgets/bank_details_modal.dart';
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
  MutualFund selected;

  double amount;
  FundingChannel channel;
  SavingsFrequency frequency;
  List<FundingChannel> channels =  [];

  //view models
  ABSInvestmentViewModel investmentViewModel;
  ABSIdentityViewModel identityViewModel;
  ABSSavingViewModel savingViewModel;
  ABSPaymentViewModel paymentViewModel;

  bool _hasFunds = false;

  File file;

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      file = File(pickedFile.path);
    });
  }


  @override
  void afterFirstLayout(BuildContext context)async {
    channels = savingViewModel.fundingChannels;
    if(channels.length == 2){
      channels.add(FundingChannel(id: 2,name: "Bank Transfer"));
    }

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
    paymentViewModel = Provider.of(context);
    savingViewModel = Provider.of(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
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
                onChange: (value){
                setState(() {
                  amount = value*100;
                });
                },title: "How much are you willing to invest",),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DropdownBorderInputWidget(title: "How often will you invest",
                onSelect: (value){
                  setState(() {
                    frequency = savingViewModel.savingFrequency
                        .firstWhere((element) => element.name == value);
                  });
                },
                items:savingViewModel
                    .savingFrequency.map((e) => e.name)
                    .toList(),
                textColor: AppColors.kPrimaryColor,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DropdownBorderInputWidget(
                title: "Select Investment Source",
                onSelect: (value) {
                  print("koo ${value}");
                  setState(() {
                    channel = channels
                        .firstWhere((element) => element.name == value);
                    print("koo ${channel.id}");
                    _hasFunds = channel.name == "Bank Transfer" ?true : channel.name == "Wallet" ?
                    paymentViewModel.wallet.hasWallet == false?false:true :
                    paymentViewModel.userCards.length == 0 ? false:true;
                  });
                  print("oooo ${_hasFunds}");
                },
                items: channels
                    .map((e) => e.name)
                    .toList(),
                textColor: AppColors.kPrimaryColor,),
            ),
            channel?.id == 2 ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: UploadWidgetBorder(title: "Proof of payment (optional)",
                desc: file == null ? "Upload your proof of payment here":"file.png",
                textColor: AppColors.kAccountTextColor,bottomMargin: 6,),
            ):SizedBox(),
            channel?.id == 2 ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text("Kindly upload the correct proof of payment to confirm "
                  "your transaction if you made "
                  "payment before initiating this transaction",style: TextStyle(fontSize: 10,color: AppColors.kAccountTextColor,height: 1.7),),
            ):SizedBox(),
            YMargin(40),
            PrimaryButton(
              title: 'Make Payment',
              horizontalMargin: 20,
              onPressed: (amount == null || _hasFunds == false || selected == null || frequency == null) ?null:  ()async {
                EasyLoading.show(status: "loading");
                var result = await investmentViewModel.buyMoneyMarketFund(
                    token: identityViewModel.user.token,
                    cardId: paymentViewModel.userCards.first.id,
                    directDebitFrequency: frequency.id,
                    fundingChannel: channel.id,
                    documentFile: file,
                    productId: selected.id,
                    amount: amount
                );
                if(result.error == false){
                  EasyLoading.showSuccess("success",
                      duration: Duration(seconds: 2));
                  if(result.data is BankPaymentDetails){
                    print("ooonnnfff");
                    showCupertinoModalBottomSheet(context: context, builder: (context){
                      return BankTransferModalBottomSheet(details: result.data,);
                    });
                  }else{

                    Navigator.of(context).pop(true);
                  }

                }else{
                  EasyLoading.showError(result.errorMessage,
                      duration: Duration(seconds: 2));
                }

              },
            )
          ],),
        )
      ),
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
                selected: selected == moneyMarketFund[index],onTap: (value){
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
  final ValueChanged<MutualFund> onTap;
  const FundWidget({
    Key key, this.fund, this.selected = false, this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap(fund);
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
