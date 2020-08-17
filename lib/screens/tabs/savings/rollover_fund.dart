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

class RollOverScreen extends StatefulWidget {
  final SavingPlanModel savingPlan;

  const RollOverScreen({Key key, this.savingPlan}) : super(key: key);
  static Route<dynamic> route(SavingPlanModel savingPlan) {
    return MaterialPageRoute(
        builder: (_) => RollOverScreen(savingPlan: savingPlan,),
        settings: RouteSettings(
            name: RollOverScreen().toStringShort()));
  }

  @override
  _RollOverScreenState createState() =>
      _RollOverScreenState();
}

class _RollOverScreenState
    extends State<RollOverScreen> {

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
          title: "Rollover",
          desc: "Extend your savings target and and keep earning",
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  children: [
                    YMargin(20),
                    DropdownBorderInputWidget(
                      title: "How do you want to save?",
                      textColor: AppColors.kPrimaryColor,
                      onSelect: (value) {

                      },
                      items: paymentViewModel.userBanks
                          .map((e) => e.name)
                          .toList(),
                    ),
                    DropdownBorderInputWidget(
                      title: "How often will you like to save",
                      textColor: AppColors.kPrimaryColor,
                      onSelect: (value) {

                      },
                      items: paymentViewModel.userBanks
                          .map((e) => e.name)
                          .toList(),
                    ),
                    AmountWidgetBorder(
                      textColor: AppColors.kAccountTextColor,
                      onChange: (value) {
                        print("ooo $value");
                        setState(() {
                          amount = value *100;
                        });

                      },
                      title: "Amount",
                    ),
                    DropdownBorderInputWidget(
                      title: "Select funding source",
                      textColor: AppColors.kPrimaryColor,
                      onSelect: (value) {

                      },
                      items: paymentViewModel.userBanks
                          .map((e) => e.name)
                          .toList(),
                    ),

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
