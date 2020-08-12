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

class AddFundScreen extends StatefulWidget {
  final SavingPlanModel savingPlan;

  const AddFundScreen({Key key, this.savingPlan}) : super(key: key);
  static Route<dynamic> route(SavingPlanModel savingPlan) {
    return MaterialPageRoute(
        builder: (_) => AddFundScreen(savingPlan: savingPlan,),
        settings: RouteSettings(
            name: AddFundScreen().toStringShort()));
  }

  @override
  _AddFundScreenState createState() =>
      _AddFundScreenState();
}

class _AddFundScreenState
    extends State<AddFundScreen> {
  bool haveBulkSum = false;
  bool selectedOthers = false;

  ABSSavingViewModel savingViewModel;
  ABSIdentityViewModel identityViewModel;
  ABSPaymentViewModel paymentViewModel;

  SavingsFrequency frequency;
  FundingChannel fundingChannel;
  bool _hasFunds = false;
  double targetAmmount = 0;
  DateTime date;
  TextEditingController controller = TextEditingController();


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
          title: "Add Fund",
          desc: "Add more money to your savings",
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  children: [
                    AmountWidgetBorder(
                      textColor: AppColors.kAccountTextColor,
                      onChange: (value) {
                        print("ooo $value");
                        setState(() {
                          targetAmmount = value *100;
                        });
                        print("ooo $targetAmmount");
                      },
                      title: "amount",
                    ),
                    DropdownBorderInputWidget(
                      title: "Funding source",
                      textColor: AppColors.kPrimaryColor,
                      onSelect: (value) {
                        print("koo ${value}");
                        setState(() {
                          fundingChannel = savingViewModel.fundingChannels
                              .firstWhere((element) => element.name == value);
                          print("koo ${fundingChannel.id}");
                         _hasFunds = fundingChannel.name == "Wallet" ?
                          paymentViewModel.wallet.hasWallet == false?false:true :
                         paymentViewModel.userCards.length == 0 ? false:true;
                        });
                      },
                      items: savingViewModel.fundingChannels
                          .map((e) => e.name)
                          .toList(),
                    ),
                    _buildNoFunds(),

                    YMargin(20),
                    Builder(
                      builder: (context) {
                        return PrimaryButton(
                          title: "Add Fund",
                          onPressed:(_hasFunds == false) ?null:  ()async {
                            EasyLoading.show(status: "loading");
                            var result = await savingViewModel.topUp(
                              token: identityViewModel.user.token,
                              cardId: paymentViewModel.userCards.first.id,
                              custSavingId: widget.savingPlan.id,
                              fundingChannel: fundingChannel.id,
                              savingsAmount: targetAmmount
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

  Widget _buildNoFunds() {
    return fundingChannel == null ?
    SizedBox(): fundingChannel.name == "Wallet" ?
    _hasFunds == false ? Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SizedBox(
            width: 270,
            child: Text(
              "You dont have any fund in your wallet, click here to add fund",
              style: TextStyle(fontSize: 12, color: AppColors.kAccentColor),
            ),
          ),
        ),
      ],
    ):SizedBox():_hasFunds == false? Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SizedBox(
            width: 270,
            child: Text(
              "You dont have any fund in your wallet, click here to add fund",
              style: TextStyle(fontSize: 12, color: AppColors.kAccentColor),
            ),
          ),
        ),
      ],
    ):SizedBox();
  }
}
