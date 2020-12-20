import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/widgets/account_widgets.dart';
import 'package:zimvest/widgets/appbars.dart';
import 'package:zimvest/widgets/bank_details_modal.dart';
import 'package:zimvest/widgets/buttons.dart';

class AddFundScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => AddFundScreen(),
        settings: RouteSettings(name: AddFundScreen().toStringShort()));
  }
  @override
  _AddFundScreenState createState() => _AddFundScreenState();
}

class _AddFundScreenState extends State<AddFundScreen> {

  String _source;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FBFB),
      appBar: ZimAppBar(title: "Add funds",),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: ListView(children: [
          YMargin(15),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text("Add more money to your investment",style: TextStyle(fontSize: 10, color: AppColors.kPrimaryColor),),
          ),
          YMargin(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AmountWidgetBorder(textColor: AppColors.kAccountTextColor,
              onChange: (value){},title: "How much are you willing to invest",),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: DropdownBorderInputWidget(title: "How often will you like to invest?",
              items: ["Treasury bill"],textColor: AppColors.kPrimaryColor,),
          ),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: DropdownBorderInputWidget(title: "Select Funding Source",
              items: ["Card Ending in 3456", "Bank Transfer"],
              textColor: AppColors.kPrimaryColor,bottomMargin: 6,onSelect: (value){
              setState(() {
                _source = value;
              });
              },),
          ),
          _source == "Bank Transfer"? ShowBankDetailsWidget():SizedBox(),
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
          showCupertinoModalBottomSheet(context: context, builder: (context){
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
