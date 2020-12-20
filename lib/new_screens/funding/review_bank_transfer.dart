import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:zimvest/new_screens/account/widgets/create_pin_widget.dart';
import 'package:zimvest/new_screens/funding/top_up_successful.dart';
import 'package:zimvest/new_screens/funding/widgets/confirm_with_pin_widget.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';

class ReviewBankTransfer extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => ReviewBankTransfer(),
        settings:
        RouteSettings(name: ReviewBankTransfer().toStringShort()));
  }
  @override
  _ReviewBankTransferState createState() => _ReviewBankTransferState();
}

class _ReviewBankTransferState extends State<ReviewBankTransfer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kSecondaryColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height - 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),

              ),
              boxShadow: AppUtils.getBoxShaddow3
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BackButton(
                    color: AppColors.kPrimaryColor,
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                  YMargin(70),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text("Savings Summary", style: TextStyle(fontFamily: AppStrings.fontMedium),),
                  ),
                  YMargin(20),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 25),
                    height: 280,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.kWhite,
                      boxShadow: AppUtils.getBoxShaddow3
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text("Account Name".toUpperCase(), style: TextStyle(fontSize: 12,
                          color: AppColors.kSecondaryText,fontFamily: AppStrings.fontNormal,),),
                        YMargin(15),
                        Text("Emmanuel West", style: TextStyle(
                            fontFamily: AppStrings.fontMedium,
                            fontSize: 13,color: AppColors.kGreyText
                        ),),
                        YMargin(40),
                        Row(children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Bank".toUpperCase(), style: TextStyle(fontSize: 12,
                                color: AppColors.kSecondaryText,fontFamily: AppStrings.fontNormal,),),
                              YMargin(15),
                              Text("Zenith Bank", style: TextStyle(
                                  fontFamily: AppStrings.fontMedium,
                                  fontSize: 13,color: AppColors.kGreyText
                              ),),
                          ],),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("Amount".toUpperCase(), style: TextStyle(fontSize: 11,
                                color: AppColors.kSecondaryText,fontFamily: AppStrings.fontNormal,),),
                              YMargin(15),
                              Text("${AppStrings.nairaSymbol}200,000", style: TextStyle(
                                  fontFamily: AppStrings.fontMedium,
                                  fontSize: 13,color: AppColors.kGreyText
                              ),),
                          ],)
                        ],),
                        YMargin(40),
                        Text("Transaction fee".toUpperCase(), style: TextStyle(fontSize: 12,
                          color: AppColors.kSecondaryText,fontFamily: AppStrings.fontNormal,),),
                        YMargin(15),
                        Text("${AppStrings.nairaSymbol}25", style: TextStyle(
                            fontFamily: AppStrings.fontMedium,
                            fontSize: 13,color: AppColors.kGreyText
                        ),),

                    ],),
                  )
              ],),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Container(
              height: 40,
              child: Column(children: [
                GestureDetector(
                  onTap: (){
                    showCupertinoModalBottomSheet(context: context, builder: (context){
                      return Container(
                        height: MediaQuery.of(context).size.height -150,
                        child: Scaffold(
                          body: ConfirmPinWidget(),
                        ),
                      );
                    });
                  },
                  child: Text("Tap to confirm", style: TextStyle(fontFamily: AppStrings.fontMedium,
                      color: Colors.white),),
                )
              ],),
            ),
          )
        ],),
      ),
    );
  }
}
