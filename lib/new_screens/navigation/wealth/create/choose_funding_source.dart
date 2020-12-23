import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/data/view_models/savings_view_model.dart';
import 'package:zimvest/new_screens/navigation/wealth/aspire/savings_summary.dart';
import 'package:zimvest/new_screens/profile/widgets/verification_failed_widget.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';

class ChooseFundingScreen extends StatefulWidget {
  const ChooseFundingScreen({
    Key key,
  }) : super(key: key);
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => ChooseFundingScreen(),
        settings:
        RouteSettings(name: ChooseFundingScreen().toStringShort()));
  }

  @override
  _ChooseFundingScreenState createState() => _ChooseFundingScreenState();
}

class _ChooseFundingScreenState extends State<ChooseFundingScreen> with AfterLayoutMixin<ChooseFundingScreen> {

  ABSPaymentViewModel paymentViewModel;
  ABSSavingViewModel savingViewModel;
  ABSIdentityViewModel identityViewModel;

  @override
  void afterFirstLayout(BuildContext context) {
    paymentViewModel.getUserCards(identityViewModel.user.token);

  }

  @override
  Widget build(BuildContext context) {
    identityViewModel = Provider.of(context);
    paymentViewModel = Provider.of(context);
    savingViewModel = Provider.of(context);
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
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
          title: Text("Create Zimvest Aspire",
            style: TextStyle(color: Colors.black87,fontSize: 13, fontFamily: AppStrings.fontMedium),),
        ),
        body: GestureDetector(
          onTap: (){
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YMargin(40),
                Text("Choose funding source", style: TextStyle(fontSize: 15,
                    color: AppColors.kGreyText,
                    fontFamily: AppStrings.fontBold),),
                YMargin(50),
                GestureDetector(
                  onTap: (){
                    showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
                      return SelectCardWidget(success: false,navigate: (){
                        Navigator.of(context).push(SavingsSummaryScreen.route());
                      },);
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      color: AppColors.kPrimaryColor,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Row(children: [
                      SvgPicture.asset("images/new/card.svg"),
                      XMargin(10),
                      Text("Debit Card", style: TextStyle(color: AppColors.kWhite,
                          fontSize: 13,fontFamily: AppStrings.fontNormal),),
                      Spacer(),
                      Icon(Icons.navigate_next_rounded,color: AppColors.kWhite,)
                    ],),
                  ),
                ),
                YMargin(25),
                GestureDetector(
                  onTap: (){
                    // savingViewModel.selectedChannel = savingViewModel
                    //     .fundingChannels.firstWhere((element) => element.name == "Wallet");
                    Navigator.of(context).push(SavingsSummaryScreen.route());
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      color: AppColors.kSecondaryColor,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Row(children: [
                      SvgPicture.asset("images/new/wallet1.svg"),
                      XMargin(10),
                      Text("Wallet", style: TextStyle(color: AppColors.kWhite,
                          fontSize: 13,fontFamily: AppStrings.fontNormal),),
                      Spacer(),
                      Text("${AppStrings.nairaSymbol} 300,000", style: TextStyle(color: AppColors.kWhite,
                          fontSize: 13,fontFamily: AppStrings.fontNormal),),
                      XMargin(5),
                      Icon(Icons.navigate_next_rounded,color: AppColors.kWhite,)
                    ],),
                  ),
                ),
                YMargin(5),
                Text("Funding with your Zimvest wallet is free",
                  style: TextStyle(fontSize: 11, fontFamily: AppStrings.fontNormal),)



              ],),
          ),
        ),
      ),
    );
  }
}