import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/local/user_local.dart';
import 'package:zimvest/data/models/payment/bank.dart';
import 'package:zimvest/data/models/payment/card.dart';
import 'package:zimvest/data/models/saving_plan.dart';
import 'package:zimvest/data/models/secondary_state.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/data/view_models/savings_view_model.dart';
import 'package:zimvest/locator.dart';
import 'package:zimvest/new_screens/account/login_screen.dart';
import 'package:zimvest/new_screens/funding/top_up_successful.dart';
import 'package:zimvest/new_screens/funding/withdraw_screen.dart';
import 'package:zimvest/new_screens/tabs.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/result.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/navigation/wealthbox_activity.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

class DeleteWealthbox extends StatelessWidget {
  const DeleteWealthbox({
    Key key, this.savingPlanModel,
  }) : super(key: key);

  final SavingPlanModel savingPlanModel;

  @override
  Widget build(BuildContext context) {
    ABSSavingViewModel savingViewModel = Provider.of(context);
    ABSIdentityViewModel identityViewModel = Provider.of(context);
    final buttonWidth = (MediaQuery
        .of(context)
        .size
        .width - 110) / 2;
    return Container(
      height: 300,
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
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.circular(25)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YMargin(20),
              Text("Close ${savingPlanModel.planName} plan", style: TextStyle(
                  fontSize: 15,
                  fontFamily: AppStrings.fontBold
              ),),
              YMargin(25),
              Text("Are you sure you want to close this savings plan, your funds "
                  "would be deposited in your wallet",
                style: TextStyle(fontSize: 11,height: 1.6,color: AppColors.kGreyText),
              ),
              YMargin(45),
              Row(children: [
                PrimaryButtonNew(
                  width: buttonWidth,
                  title: "Yes",
                  onTap: ()async{
                    Navigator.of(context).pop();
                    Navigator.pop(context);
                    EasyLoading.show(status: "");
                    var result = await savingViewModel.terminateSavings(
                      token: identityViewModel.user.token,
                      productId: savingPlanModel.id
                    );
                    if(result.error == false){
                      EasyLoading.showSuccess("Plan was deleted successfully",
                          duration: Duration(seconds: 3));
                    }else{
                      EasyLoading.showError(result.errorMessage,
                          duration: Duration(seconds: 3));
                    }

                  },
                ),
                XMargin(20,),
                PrimaryButtonNew(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  textColor: AppColors.kPrimaryColor,
                  bg:AppColors.kPrimaryColor.withOpacity(0.2),
                  width: buttonWidth,
                  title: "No",
                )
              ],)


            ],),
        )),
        YMargin(30)
      ],),
    );
  }
}
class DeleteCardOrBank extends StatelessWidget {
  const DeleteCardOrBank({
    Key key, this.card, this.bank,
  }) : super(key: key);

  final PaymentCard card;
  final Bank bank;

  @override
  Widget build(BuildContext context) {
    ABSPaymentViewModel paymentViewModel = Provider.of(context);
    ABSIdentityViewModel identityViewModel = Provider.of(context);
    final buttonWidth = (MediaQuery
        .of(context)
        .size
        .width - 110) / 2;
    return Container(
      height: 300,
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
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.circular(25)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YMargin(20),
              Text("Delete ${card == null ? 'Bank account': 'Card'}", style: TextStyle(
                  fontSize: 15,
                  fontFamily: AppStrings.fontBold
              ),),
              YMargin(25),
              Text("Are you sure you want to delete your ${card == null ? 'Bank account': 'Card'}",
                style: TextStyle(fontSize: 11,height: 1.6,color: AppColors.kGreyText),
              ),
              YMargin(45),
              Row(children: [
                PrimaryButtonNew(
                  width: buttonWidth,
                  title: "Yes",
                  onTap: ()async{

                    EasyLoading.show(status: "");
                    Result result;
                    if(card == null){
                      result = await paymentViewModel.deleteBank(
                          identityViewModel.user.token, bank.id);
                    }else{
                      result = await paymentViewModel.deleteCard(
                          identityViewModel.user.token, card.id);
                    }
                    EasyLoading.dismiss();

                    if(result.error == false){
                      showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
                        return PasswordSuccessWidget(
                          message: "${card != null ? 'Card':'Bank Account'} deleted Succesfully",
                          onDone: (){
                            Navigator.of(context).pop();
                            Navigator.pop(context);
                          },success: true,
                        );
                      },isDismissible: false);
                    }else{
                      showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
                        return PasswordSuccessWidget(
                          message: result.errorMessage,
                          onDone: (){
                            Navigator.of(context).pop();
                            Navigator.pop(context);
                          },success: false,
                        );
                      },isDismissible: false);
                    }


                  },
                ),
                XMargin(20,),
                PrimaryButtonNew(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  textColor: AppColors.kPrimaryColor,
                  bg:AppColors.kPrimaryColor.withOpacity(0.2),
                  width: buttonWidth,
                  title: "No",
                )
              ],)


            ],),
        )),
        YMargin(30)
      ],),
    );
  }
}
class CardMore extends StatelessWidget {
  const CardMore({
    Key key, this.card, this.bank,
  }) : super(key: key);

  final PaymentCard card;
  final Bank bank;

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        children: [
          YMargin(10),
          Center(
            child: Container(
              width: 30,
              height: 5,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
            ),
          ),
          YMargin(20),
          Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                child: SafeArea(
                  child: Column(
                    children: [
                      YMargin(40),
                      Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Column(children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              showModalBottomSheet<Null>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DeleteCardOrBank(card: card,bank: bank,);
                                  },
                                  isScrollControlled: true);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  SvgPicture.asset('images/new/delete_plan.svg'),
                                  XMargin(15),
                                  Text(
                                    "Delete ${bank == null ? 'Card':"Bank Account"}",
                                    style: TextStyle(fontFamily: AppStrings.fontNormal),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.navigate_next_rounded,
                                    color: AppColors.kPrimaryColor,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],),
                      ),

                    ],
                  ),
                ),
              ))
        ],
      ),
    );

  }
}
class WithdrawWealthbox extends StatelessWidget {
  const WithdrawWealthbox({
    Key key, this.savingPlanModel, this.onTapYes, this.prompt,
  }) : super(key: key);

  final SavingPlanModel savingPlanModel;
  final VoidCallback onTapYes;
  final String prompt;

  @override
  Widget build(BuildContext context) {
    ABSSavingViewModel savingViewModel = Provider.of(context);
    ABSIdentityViewModel identityViewModel = Provider.of(context);
    final buttonWidth = (MediaQuery
        .of(context)
        .size
        .width - 110) / 2;
    return Container(
      height: 300,
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
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.circular(25)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YMargin(20),
              Text("Withdraw ${savingPlanModel.planName} plan", style: TextStyle(
                  fontSize: 15,
                  fontFamily: AppStrings.fontBold
              ),),
              YMargin(20),
              Text(prompt ?? "You would be charged 10% of your accrued interest for liquidating outside of withdrawal days, Would you like to proceed",
                style: TextStyle(fontSize: 11,height: 1.6,color: AppColors.kGreyText),
              ),
              YMargin(25),
              Row(children: [
                PrimaryButtonNew(
                  width: buttonWidth,
                  title: "Yes",
                  onTap: onTapYes,
                ),
                XMargin(20,),
                PrimaryButtonNew(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  textColor: AppColors.kPrimaryColor,
                  bg:AppColors.kPrimaryColor.withOpacity(0.2),
                  width: buttonWidth,
                  title: "No",
                )
              ],)


            ],),
        )),
        YMargin(30)
      ],),
    );
  }
}
class CancelAction extends StatelessWidget {
  const CancelAction({
    Key key,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    ABSSavingViewModel savingViewModel = Provider.of(context);
    ABSIdentityViewModel identityViewModel = Provider.of(context);
    ABSPaymentViewModel paymentViewModel = Provider.of(context);
    final buttonWidth = (MediaQuery
        .of(context)
        .size
        .width - 110) / 2;
    return Container(
      height: 300,
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
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.circular(25)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YMargin(20),
              Text("Cancel", style: TextStyle(
                  fontSize: 15,
                  fontFamily: AppStrings.fontBold
              ),),
              YMargin(25),
              Text("Are you sure you want to cancel this operation",
                style: TextStyle(fontSize: 11,height: 1.6,color: AppColors.kGreyText),
              ),
              YMargin(45),
              Row(children: [
                PrimaryButtonNew(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  textColor: AppColors.kPrimaryColor,
                  bg: AppColors.kPrimaryColor.withOpacity(0.2),
                  width: buttonWidth,
                  title: "No",
                ),
                XMargin(20,),
                PrimaryButtonNew(
                  width: buttonWidth,
                  title: "Yes",
                  onTap: ()async{
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => TabsContainer()),
                            (Route<dynamic> route) => false);
                    Future.delayed(Duration(seconds: 1)).then((value) {
                      savingViewModel.startDate = null;
                      savingViewModel.image = null;
                      savingViewModel.selectedChannel = null;
                      paymentViewModel.selectedCard = null;
                      paymentViewModel.selectedBank = null;
                      savingViewModel.amountToSave = 0.0;
                      savingViewModel.autoSave = null;
                      savingViewModel.selectedFrequency = null;
                    });

                  },
                ),


              ],)


            ],),
        )),
        YMargin(30)
      ],),
    );
  }
}
class LogOutAction extends StatelessWidget {
  const LogOutAction({
    Key key,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    ABSSavingViewModel savingViewModel = Provider.of(context);
    ABSIdentityViewModel identityViewModel = Provider.of(context);
    ABSPaymentViewModel paymentViewModel = Provider.of(context);
    final buttonWidth = (MediaQuery
        .of(context)
        .size
        .width - 110) / 2;
    return Container(
      height: 300,
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
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.circular(25)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YMargin(20),
              Text("Log Out", style: TextStyle(
                  fontSize: 15,
                  fontFamily: AppStrings.fontBold
              ),),
              YMargin(25),
              Text("Are you sure you want to Logout?",
                style: TextStyle(fontSize: 11,height: 1.6,color: AppColors.kGreyText),
              ),
              YMargin(45),
              Row(children: [
                PrimaryButtonNew(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  textColor: AppColors.kPrimaryColor,
                  bg: AppColors.kPrimaryColor.withOpacity(0.2),
                  width: buttonWidth,
                  title: "No",
                ),
                XMargin(20,),
                PrimaryButtonNew(
                  width: buttonWidth,
                  title: "Yes",
                  onTap: ()async{
                    _logout(context);
                    Future.delayed(Duration(seconds: 1)).then((value) {
                      savingViewModel.startDate = null;
                      savingViewModel.image = null;
                      savingViewModel.selectedChannel = null;
                      paymentViewModel.selectedCard = null;
                      paymentViewModel.selectedBank = null;
                      savingViewModel.amountToSave = 0.0;
                      savingViewModel.autoSave = null;
                      savingViewModel.selectedFrequency = null;
                    });

                  },
                ),


              ],)


            ],),
        )),
        YMargin(30)
      ],),
    );
  }
  void _logout(BuildContext context) {

    final box = Hive.box(AppStrings.state);
    final ABSStateLocalStorage _localStorage = locator<ABSStateLocalStorage>();
    box.put("user", null);
    SecondaryState state = SecondaryState(false, email: _localStorage.getSecondaryState().email, password: _localStorage.getSecondaryState().password);
    box.put("state", state);
    // _investmentViewModel.reset();
    Navigator.of(context, rootNavigator: true).pop();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
            (Route<dynamic> route) => false);
  }
}

class ConfirmSavings extends StatelessWidget {
  const ConfirmSavings({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonWidth = (MediaQuery
        .of(context)
        .size
        .width - 110) / 2;
    return Container(
      height: 300,
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
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.circular(25)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YMargin(20),
              Text("Confirm Wealthbox plan", style: TextStyle(
                  fontSize: 15,
                  fontFamily: AppStrings.fontBold
              ),),
              YMargin(25),
              Text("I agree to forfeit 15% of my accrued interest if I "
                  "withdraw on any day aside 1st day of every quarter",
                style: TextStyle(fontSize: 11,height: 1.6,color: AppColors.kGreyText),
              ),
              YMargin(45),
              Row(children: [
                PrimaryButtonNew(
                  width: buttonWidth,
                  title: "No",
                  textColor: AppColors.kPrimaryColor,
                  bg: AppColors.kPrimaryColorLight,
                ),
                XMargin(20,),
                PrimaryButtonNew(
                  textColor: AppColors.kWhite,
                  bg: AppColors.kPrimaryColor,
                  width: buttonWidth,
                  onTap: (){
                    Navigator.push(context, TopUpSuccessful.route());
                  },
                  title: "Yes",
                )
              ],)


            ],),
        )),
        YMargin(30)
      ],),
    );
  }
}