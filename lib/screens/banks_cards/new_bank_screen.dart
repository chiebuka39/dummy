import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/models/payment/bank.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/widgets/account_widgets.dart';
import 'package:zimvest/widgets/appbars.dart';
import 'package:zimvest/widgets/buttons.dart';

class NewBankScreen extends StatefulWidget {
  final List<Bank> banks;

  const NewBankScreen({Key key, this.banks}) : super(key: key);
  static Route<dynamic> route({List<Bank> banks}) {
    return MaterialPageRoute(
        builder: (_) => NewBankScreen(banks: banks,),
        settings: RouteSettings(name: NewBankScreen().toStringShort()));
  }
  @override
  _NewBankScreenState createState() => _NewBankScreenState();
}

class _NewBankScreenState extends State<NewBankScreen> {
  ABSPaymentViewModel _paymentViewModel;
  ABSIdentityViewModel _identityViewModel;
  List<Bank> banks;
  Bank selectedBank;
  String accountNum;
  List<String> userBankData;

  @override
  void initState() {
    if(widget.banks != null){
      banks = widget.banks;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    _paymentViewModel = Provider.of(context);
    _identityViewModel = Provider.of(context);
    return Scaffold(
      appBar: ZimAppBar(title: "Add new bank",),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          YMargin(20),
          DropdownBorderInputWidget(title: "Bank Name",
            textColor: AppColors.kAccountTextColor,
            items: banks.map((e) => e.name).toList(),
            onSelect: (value){
            Bank bank = banks.where((element) =>
            element.name == value).toList().first;
            setState(() {
              selectedBank = bank;
            });
            },
          ),
          TextWidgetBorder(title: "Account Number",textColor: AppColors.kAccountTextColor,
            keyboardType: TextInputType.number,onChange: (value){
            setState(() {
              accountNum = value;
            });
            },),
          YMargin(20),
          userBankData == null ? SizedBox():Container(
            height: 75,
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.kPrimaryColor,
              borderRadius: BorderRadius.circular(7)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              Text(userBankData[0],
                style: TextStyle(fontSize: 16, fontFamily: "Caros-Bold", color: AppColors.kWhite),),
              Text(userBankData[1], style: TextStyle(color: AppColors.kLightText, fontSize: 12),),
            ],),
          ),
          PrimaryButton(
            title: userBankData == null ?  "Validate Bank":"Add Bank",
            onPressed: ()async{
              var result = await _paymentViewModel.validateBank(
                token: _identityViewModel.user.token,
                accountNum:accountNum,
                bankCode: selectedBank.code
              );
              if(result.error == false){
                setState(() {
                  userBankData = result.data;
                });
              }
            },
          )
        ],),
      ),
    );
  }
}
