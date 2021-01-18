import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/models/payment/bank.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/new_screens/withdrawals/add_bank_account_2.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/utils/validator.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

class AddBankAccScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => AddBankAccScreen(),
        settings:
        RouteSettings(name: AddBankAccScreen().toStringShort()));
  }
  @override
  _AddBankAccScreenState createState() => _AddBankAccScreenState();
}

class _AddBankAccScreenState extends State<AddBankAccScreen> with AfterLayoutMixin<AddBankAccScreen> {

  String accNumber;

  List<Bank> banks;

  bool autoValidate = false;

  ABSPaymentViewModel paymentViewModel;
  ABSIdentityViewModel identityViewModel;

  @override
  void afterFirstLayout(BuildContext context) async{
    var result  = await paymentViewModel.getBanks(identityViewModel.user.token);

    if(result.error == false){
      setState(() {
        banks = result.data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    paymentViewModel = Provider.of(context);
    identityViewModel = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.kPrimaryColor),
        leading: IconButton(
          icon: Icon(Icons.clear,size: 20,),
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
                child: TextField(
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
            YMargin(100),
            RoundedNextButton(

                onTap: () async{
                  setState(() {
                    autoValidate = true;
                  });
                  if( accNumber.length != 10){
                    return;
                  }
                  if(banks ==null){
                    showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
                      return NoInternetWidget(onDone: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },message: "Your Upload was successfully",);
                    });
                  }else{
                    Navigator.push(context, AddBankAccScreen2.route(accountNumber: accNumber, banks: banks));

                  }

                  //
                }
            ),
            YMargin(120)
          ],),
      ),
    );
  }
}
