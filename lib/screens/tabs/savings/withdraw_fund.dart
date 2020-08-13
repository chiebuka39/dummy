import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/models/saving_plan.dart';
import 'package:zimvest/data/models/savings/funding_channels.dart';
import 'package:zimvest/data/models/savings/savings_frequency.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/data/view_models/savings_view_model.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/account_widgets.dart';
import 'package:zimvest/widgets/appbars.dart';
import 'package:zimvest/widgets/buttons.dart';

class WithdrawFundScreen extends StatefulWidget {
  final SavingPlanModel savingPlan;

  const WithdrawFundScreen({Key key, this.savingPlan}) : super(key: key);
  static Route<dynamic> route(SavingPlanModel savingPlan) {
    return MaterialPageRoute(
        builder: (_) => WithdrawFundScreen(savingPlan: savingPlan,),
        settings: RouteSettings(
            name: WithdrawFundScreen().toStringShort()));
  }

  @override
  _WithdrawFundScreenState createState() =>
      _WithdrawFundScreenState();
}

class _WithdrawFundScreenState
    extends State<WithdrawFundScreen> {

  ABSSavingViewModel savingViewModel;
  ABSIdentityViewModel identityViewModel;
  ABSPaymentViewModel paymentViewModel;

  bool _hasFunds = false;
  double amount = 0;
  DateTime date;



  @override
  Widget build(BuildContext context) {
    savingViewModel = Provider.of(context);
    identityViewModel = Provider.of(context);
    paymentViewModel = Provider.of(context);
    print("kkk ${paymentViewModel.userCards.first.id}");
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        backgroundColor: Color(0xFFF8FBFB),
        appBar: ZimAppBar(
          title: "Aspire Withdrawal",
          desc: "Use the form below to withdraw from your aspire instantly",
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  children: [
                    YMargin(20),
                    AmountWidgetBorder(
                      textColor: AppColors.kAccountTextColor,
                      onChange: (value) {
                        print("ooo $value");
                        setState(() {
                          amount = value *100;
                        });

                      },
                      title: "How much would you like to withdraw",
                    ),
                    DropdownBorderInputWidget(
                      title: "Select Withdrawal bank",
                      textColor: AppColors.kPrimaryColor,
                      onSelect: (value) {

                      },
                      items: paymentViewModel.userBanks
                          .map((e) => e.name)
                          .toList(),
                    ),
                    LoginPasswordOutlineWidget(title: "Please enter your password",titleColor: AppColors.kAccountTextColor,),
                    YMargin(20),
                    Builder(
                      builder: (context) {
                        return PrimaryButton(
                          title: "Withdraw Funds",
                          onPressed:(_hasFunds == false) ?null:  ()async {
                            EasyLoading.show(status: "loading");
                            var result = await savingViewModel.topUp(
                              token: identityViewModel.user.token,
                              cardId: paymentViewModel.userCards.first.id,
                              custSavingId: widget.savingPlan.id,

                            );
                            if(result.error == false){
                              EasyLoading.showSuccess("success",
                                  duration: Duration(seconds: 2));
                            }else{
                              EasyLoading.showError(result.errorMessage,
                                  duration: Duration(seconds: 2));
                            }

                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}
