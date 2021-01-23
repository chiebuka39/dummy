import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/models/payment/bank.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/data/view_models/pin_view_model.dart';
import 'package:zimvest/data/view_models/savings_view_model.dart';
import 'package:zimvest/new_screens/profile/add_bank_cards.dart';
import 'package:zimvest/new_screens/withdrawals/use_pin_widget.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/utils/validator.dart';
import 'package:zimvest/widgets/account_widgets.dart';
import 'package:zimvest/widgets/buttons.dart';

class AddBankAccScreen2 extends StatefulWidget {
  final List<Bank> banks;
  final String accountNumber;

  const AddBankAccScreen2({Key key,
    this.banks,
    this.accountNumber}) : super(key: key);

  static Route<dynamic> route({List<Bank> banks, String accountNumber}) {
    return MaterialPageRoute(
        builder: (_) => AddBankAccScreen2(banks: banks,accountNumber: accountNumber,),
        settings:
        RouteSettings(name: AddBankAccScreen2().toStringShort()));
  }
  @override
  _AddBankAccScreenState createState() => _AddBankAccScreenState();
}

class _AddBankAccScreenState extends State<AddBankAccScreen2> {

  String accNumber;
  List<Bank> banks;

  bool autoValidate = false;

  Bank selectedBank;

  bool loading = false;

  ABSPaymentViewModel paymentViewModel;
  ABSIdentityViewModel identityViewModel;

  @override
  void initState() {
    accNumber = widget.accountNumber;
    banks = widget.banks;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    identityViewModel = Provider.of(context);
    paymentViewModel = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.kPrimaryColor),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined,size: 20,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        title: Text("Add Bank Account",
          style: TextStyle(color: Colors.black87,
              fontSize: 13,
              fontFamily: AppStrings.fontMedium),),

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YMargin(50),
              Text("Enter Account Number"),
              YMargin(30),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.kGreyBg,
                    borderRadius: BorderRadius.circular(12)
                ),
                child: Transform.translate(
                  offset: Offset(0,5),
                  child: TextFormField(
                    initialValue: accNumber,
                  keyboardType: TextInputType.number,
                    onChanged: (value){
                      accNumber = value;
                      setState(() {});
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Account Number",
                        hintStyle: TextStyle(
                            fontSize: 14
                        )
                    ),
                  ),
                ),
              ),
              if (autoValidate == false ? false : accNumber.length != 10) Padding(
                padding: const EdgeInsets.only(left: 5,top: 5),
                child: Text("Invalid Account number", style: TextStyle(fontSize: 11,color: AppColors.kRed),),
              ) else SizedBox(),
              YMargin(40),
              DropdownBorderInputWidget(title: "Bank Name",
                textColor: AppColors.kAccountTextColor,
                items: banks.map((e) => e.name).toList(),
                labelSize: 15,
                source: selectedBank?.name ?? null,
                onSelect: (value){
                  Bank bank = banks.where((element) =>
                  element.name == value).toList().first;
                  setState(() {
                    selectedBank = bank;
                  });
                },
              ),
              YMargin(100),
              RoundedNextButton(
                  loading: loading,
                  onTap: () async{
                    setState(() {
                      autoValidate = true;
                    });
                    if( accNumber.length != 10){
                      return;
                    }
                    EasyLoading.show(status: '');
                    var result = await paymentViewModel.validateBank(
                        token: identityViewModel.user.token,
                        accountNum: accNumber,
                        bankCode: selectedBank.code,
                        customerId: 0
                    );
                    EasyLoading.dismiss();
                    if(result.error == true){

                      AppUtils.showError(context,title: 'We could not add your bank',
                          message: result.errorMessage);
                      print("login failed");
                      //widget.onNext(phoneNumber);
                    }else{
                      showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
                        return ShowBankDetailsWidget(
                          bank: selectedBank,
                          accNum: accNumber,
                          name: result.data[0],
                        );
                      });

                      print("success");
                      //Navigator.of(context).pushReplacement(TabsContainer.route());
                    }

                    //
                  }
              ),
              YMargin(120)
            ],),
        ),
      ),
    );
  }
}

class ShowBankDetailsWidget extends StatefulWidget {
  const ShowBankDetailsWidget({
    Key key, this.accNum, this.name, this.bank,
  }) : super(key: key);

  final String accNum;
  final String name;
  final Bank bank;


  @override
  _SelectCardWidgetState createState() => _SelectCardWidgetState();
}

class _SelectCardWidgetState extends State<ShowBankDetailsWidget> {

  ABSPaymentViewModel paymentViewModel;
  ABSIdentityViewModel identityViewModel;
  ABSPinViewModel pinViewModel;

  @override
  Widget build(BuildContext context) {
    identityViewModel = Provider.of(context);
    paymentViewModel = Provider.of(context);
    pinViewModel = Provider.of(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(children: [
        YMargin(10),
        Center(child: Container(
          width: 30,
          height: 5,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5)
          ),
        ),),
        YMargin(20),
        Expanded(child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25)
              )
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YMargin(40),
                Text("Confirmation", style: TextStyle(fontSize: 15, fontFamily: AppStrings.fontBold),),
                YMargin(15),
                Text("Please confirm your bank details", style: TextStyle(fontSize: 11, fontFamily: AppStrings.fontNormal),),
                YMargin(30),
                Text(widget.name, style: TextStyle(fontSize: 16,
                    fontFamily: AppStrings.fontBold),),
                YMargin(18),
                Text(widget.accNum, style: TextStyle(fontSize: 12, fontFamily: AppStrings.fontNormal),),
                YMargin(15),
                Text(widget.bank.name, style: TextStyle(fontSize: 12, fontFamily: AppStrings.fontNormal),),
                Spacer(),
                Center(
                  child: PrimaryButtonNew(
                    onTap: (){

                      //processTransaction();
                      showCupertinoModalBottomSheet(context: context, builder: (context){
                        return UsePinWidget(
                          onNext: processTransaction,
                        );
                      });
                    },
                    title: "Confirm",
                    width: 200,
                  ),
                ),

                Spacer(),
              ],),
          ),
        ))
      ],),
    );
  }

  processTransaction() async {

    EasyLoading.show(status: "Add Bank");
    var res = await identityViewModel.verifyPin(
      code: "${pinViewModel.pin1}${pinViewModel.pin2}${pinViewModel.pin3}${pinViewModel.pin4}",
    );
    if(res.error == true){
      EasyLoading.showError(res.errorMessage, duration: Duration(seconds: 2));
      pinViewModel.resetPins();
    }else{
      var result = await paymentViewModel.addBank(
          token: identityViewModel.user.token,
          bankId: widget.bank.id,
          accountNum: widget.accNum,
          accountName: widget.name,
          bankName: widget.bank.name
      );

      if(result.error == false){
        EasyLoading.showSuccess("Success",duration: Duration(seconds: 2));
      }else{
        EasyLoading.showError(result.errorMessage, duration: Duration(seconds: 2));
      }
      pinViewModel.resetPins();

      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context, true);
    }



  }
}
//0690000031