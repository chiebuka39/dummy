import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/widgets/account_widgets.dart';
import 'package:zimvest/widgets/appbars.dart';
import 'package:zimvest/widgets/buttons.dart';

class WithdrawFundScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => WithdrawFundScreen(),
        settings: RouteSettings(name: WithdrawFundScreen().toStringShort()));
  }
  @override
  _WithdrawFundScreenState createState() => _WithdrawFundScreenState();
}

class _WithdrawFundScreenState extends State<WithdrawFundScreen> {

  String _source;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FBFB),
      appBar: ZimAppBar(title: "Add funds",desc: 'Use the form below to complete your withdrawal',),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: ListView(children: [
          YMargin(15),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AmountWidgetBorder(textColor: AppColors.kAccountTextColor,
              onChange: (value){},title: "Enter amount",),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: DropdownBorderInputWidget(title: "Select Withdrawal bank",
              items: ["Access bank","Heritage bank"],textColor: AppColors.kPrimaryColor,),
          ),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: LoginPasswordOutlineWidget(title: "Please enter your password",titleColor: AppColors.kAccountTextColor,),
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

class ShowBankDetailsWidget extends StatelessWidget {
  const ShowBankDetailsWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Column(children: [
      InkWell(
        onTap: (){
          showCupertinoModalBottomSheet(context: context, builder: (context,d){
            return BankTransferModalBottomSheet();
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(children: [
            Icon(Icons.arrow_forward, size: 16,color: AppColors.kAccentColor,),
            Text("View Bank account details",
              style: TextStyle(fontSize: 12,color: AppColors.kAccentColor),)
          ],),
        ),
      ),
      YMargin(20),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: UploadWidgetBorder(title: "Proof of payment (optional)",
          desc: "Upload your proof of payment here",
          textColor: AppColors.kAccountTextColor,bottomMargin: 6,),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text("Kindly upload the correct proof of payment to confirm "
            "your transaction if you made "
            "payment before initiating this transaction",style: TextStyle(fontSize: 10,color: AppColors.kAccountTextColor,height: 1.7),),
      ),
    ],),);
  }
}

class BankTransferModalBottomSheet extends StatelessWidget {
  const BankTransferModalBottomSheet({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 100,
      color: AppColors.kLightBG,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              YMargin(5),
                Container(
                  height: 5,
                  width: 92,
                  decoration: BoxDecoration(
                      color: AppColors.kLightText,
                    borderRadius: BorderRadius.circular(4)
                  ),
                ),
              YMargin(22),
              Text("Bank Transfer", style: TextStyle(color: AppColors.kPrimaryColor,
                  fontFamily: "Caros-Bold",fontSize: 16),),
                YMargin(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(text: 'To complete this payment, '
                            'kindly Select any of the bank accounts '
                            'listed below that you want to transfer the '
                            'sum of ',
                            style: TextStyle(color: AppColors.kPrimaryColor,
                                fontSize: 12, height: 1.85)),
                        TextSpan(text: 'NGN 10,000,000 ',
                            style: TextStyle(color: AppColors.kPrimaryColor,
                                fontSize: 12, height: 1.85, fontFamily: "Caros-Bold")),
                        TextSpan(text: ' to, Include your unique ',
                            style: TextStyle(color: AppColors.kPrimaryColor,
                                fontSize: 12, height: 1.85)),
                        TextSpan(text: 'Reference Number',
                            style: TextStyle(color: AppColors.kPrimaryColor,
                                fontSize: 12, height: 1.85, fontFamily: "Caros-Bold")),
                        TextSpan(text: '  below, your payment won’t be confirmed without the ',
                            style: TextStyle(color: AppColors.kPrimaryColor,
                                fontSize: 12, height: 1.85,)),
                        TextSpan(text: 'Reference Number',
                            style: TextStyle(color: AppColors.kPrimaryColor,
                                fontSize: 12, height: 1.85,fontFamily: "Caros-Bold")),
                      ]
                    ),
                  ),
                ),
                YMargin(16),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: 82,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.kPrimaryColor,
                    borderRadius: BorderRadius.circular(4)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                    Text("Make your Bank transfer using your Reference Number",
                      style: TextStyle(color: AppColors.kLightText,fontSize: 10),),
                    Text("XR123UI45R",
                      style: TextStyle(color: AppColors.kAccentColor,
                          fontSize: 22, fontFamily: "Caros-Bold"),),

                  ],),
                ),
                YMargin(15),
                AccountDetails(bank: "Zenith Bank",
                  accountName: "ZEDCREST INVESTMENT MANAGERS LIMITED",
                  accountNumber: "1234567890",
                ),
                YMargin(10),
                AccountDetails(bank: "First City Monument Bank(FCMB)",
                  accountName: "ZEDCREST INVESTMENT MANAGERS LIMITED",
                  accountNumber: "1234567890",
                ),
                YMargin(30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(children: [
                    Expanded(
                      flex: 3,
                      child: FlatButton(
                        onPressed:(){},
                        child: Row(
                          children: [
                            Icon(Icons.file_download),
                            Text("Download account details", style: TextStyle(fontSize: 10),)
                          ],
                        ),
                      ),
                    ),
                    XMargin(15),
                    Expanded(
                      flex: 2,
                      child: PrimaryButton(
                        title: "Continue",
                        onPressed: (){},
                      ),
                    )
                  ],),
                ),
                YMargin(40),
            ],),
          ),
        ),
      ),
    );
  }
}

class AccountDetails extends StatelessWidget {
  final String bank;
  final String accountName;
  final String accountNumber;
  const AccountDetails({
    Key key, this.bank, this.accountName, this.accountNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: AppColors.kLightText,
      ),
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
      height: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text(bank, style: TextStyle(
              fontSize: 14, fontFamily: "Caros-Medium", color: AppColors.kPrimaryColor),)
        ],),
        Spacer(),
        Text("Account name:", style: TextStyle(
            fontSize: 12, color: AppColors.kPrimaryColor2),),
        YMargin(5),
        Text(accountName, style: TextStyle(
            fontSize: 10, color: AppColors.kAccountTextColor),),
          YMargin(15),
          Text("Account number:", style: TextStyle(
              fontSize: 12, color: AppColors.kPrimaryColor2),),
          YMargin(5),
          Text(accountNumber, style: TextStyle(
              fontSize: 10, color: AppColors.kAccountTextColor),)
      ],),
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
