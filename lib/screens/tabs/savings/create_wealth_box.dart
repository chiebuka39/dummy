import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
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

class CreateZimvestWealthBoxScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => CreateZimvestWealthBoxScreen(),
        settings: RouteSettings(
            name: CreateZimvestWealthBoxScreen().toStringShort()));
  }

  @override
  _CreateZimvestWealthBoxScreenState createState() =>
      _CreateZimvestWealthBoxScreenState();
}

class _CreateZimvestWealthBoxScreenState
    extends State<CreateZimvestWealthBoxScreen> {
  bool haveBulkSum = false;
  bool selectedOthers = false;

  ABSSavingViewModel savingViewModel;
  ABSIdentityViewModel identityViewModel;
  ABSPaymentViewModel paymentViewModel;

  SavingsFrequency frequency;
  FundingChannel fundingChannel;
  bool _hasFunds = false;
  double targetAmount = 0;
  DateTime date;
  TextEditingController controller = TextEditingController();

  var _agreed = false;

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
          desc: "Our Zimvest Aspire plan allows you to conveniently "
              "save a mimimum amount of ₦1000, either daily, "
              "weekly or monthly for as long as you "
              "want and get an interest of 14%",
          title: "Create New Zimvest Wealth Box",
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  children: [
                    DropdownBorderInputWidget(
                      title: "How often would you like to save",
                      textColor: AppColors.kPrimaryColor,
                      onSelect: (value) {
                        setState(() {
                          frequency = savingViewModel.savingFrequency
                              .firstWhere((element) => element.name == value);
                        });
                      },
                      items: savingViewModel.savingFrequency
                          .map((e) => e.name)
                          .toList(),
                    ),
                    AmountWidgetBorder(
                      textColor: AppColors.kAccountTextColor,
                      onChange: (value) {
                        setState(() {
                          targetAmount = value;
                        });
                      },
                      title: "Target amount",
                    ),
                    DateOfBirthBorderInputWidget(
                      title: "Start Date",
                      startDate: DateTime.now(),
                      initialDate: DateTime.now(),
                      endDate: DateTime.utc(2030),
                      textColor: AppColors.kAccountTextColor,
                      setDate: (value) {
                        setState(() {
                          date = value;
                        });
                      },
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

                    Row(
                      children: [
                        Theme(
                          data: ThemeData(
                              unselectedWidgetColor: AppColors.kAccentColor),
                          child: Checkbox(
                            onChanged: (bool value) {
                              setState(() {
                                _agreed = value;
                              });
                            },
                            value: _agreed,
                            activeColor: AppColors.kAccentColor,
                          ),
                        ),
                        XMargin(15),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    fontFamily: "Caros",
                                    color: AppColors.kAccountTextColor,
                                    fontSize: 10,
                                    height: 1.5),
                                children: [
                                  TextSpan(text: "I agree that I will "),
                                  TextSpan(
                                      text: "50% of my interest accrued ",
                                      style:
                                          TextStyle(fontFamily: "Caros-Bold")),
                                  TextSpan(
                                      text:
                                          "on this target savings if I fail to meet "),
                                  TextSpan(
                                      text: "at least 70% ",
                                      style:
                                          TextStyle(fontFamily: "Caros-Bold")),
                                  TextSpan(
                                      text:
                                          "of my target amount at the point of withdrawal."),
                                ]),
                          ),
                        ),
                      ],
                    ),
                    YMargin(20),
                    Builder(
                      builder: (context) {
                        return PrimaryButton(
                          title: "Create Plan",
                          onPressed:(_agreed == false || _hasFunds == false) ?null:  ()async {
                            EasyLoading.show(status: "loading");
                            var result = await savingViewModel.createWealthBox(
                              token: identityViewModel.user.token,
                              cardId: paymentViewModel.userCards.first.id,
                              frequency: frequency.id,
                              fundingChannel: fundingChannel.id,
                              startDate: date,
                              savingsAmount: targetAmount
                            );
                            if(result.error == false){
                              EasyLoading.showSuccess("success",
                                  duration: Duration(seconds: 2));
                              Navigator.of(context).pop(true);
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
