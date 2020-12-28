import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/models/savings/aspire_target.dart';
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

class CreateZimvestAspireScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => CreateZimvestAspireScreen(),
        settings: RouteSettings(name: CreateZimvestAspireScreen().toStringShort()));
  }
  @override
  _CreateZimvestAspireScreenState createState() => _CreateZimvestAspireScreenState();
}

class _CreateZimvestAspireScreenState extends State<CreateZimvestAspireScreen> {
  bool haveBulkSum = false;
  bool selectedOthers = false;

  String _planName;
  double targetAmount;
  double savingAmount;
  DateTime maturityDate;
  DateTime startDate;
  double bulkSum;
  SavingsFrequency frequency;
  AspireTarget aspireTarget;

  ABSSavingViewModel savingViewModel;
  ABSIdentityViewModel identityViewModel;
  ABSPaymentViewModel paymentViewModel;

  int _progress = 0;

  FundingChannel fundingChannel;

  bool _hasFunds = false;

  bool _agreed = false;
  @override
  Widget build(BuildContext context) {
    savingViewModel = Provider.of(context);
    identityViewModel = Provider.of(context);
    paymentViewModel = Provider.of(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        backgroundColor: Color(0xFFF8FBFB),
        body: Column(children: [
          ZimAppBar(desc:  "Our Zimvest Aspire plan allows you to conveniently "
              "save a mimimum amount of ₦1000, either daily, "
              "weekly or monthly for as long as you "
              "want and get an interest of 14%",),
          _progress == 0 ?Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child:ListView(
                children: [
                  TextWidgetBorder(
                    title: "Plan Name",
                    onChange: (value){
                      setState(() {
                        _planName = value;
                      });
                    },
                    textColor: AppColors.kPrimaryColor,
                  ),
                  AmountWidgetBorder(textColor: AppColors.kAccountTextColor,
                    onChange: (value){
                      setState(() {
                        targetAmount = value *100;
                      });
                    },title: "Target amount",),
                  DateOfBirthBorderInputWidget(title: "Maturity Date",
                    textColor: AppColors.kAccountTextColor,
                    selected: maturityDate,
                    startDate: DateTime.now().add(Duration(days: 90)),
                    initialDate: DateTime.now().add(Duration(days: 90)),
                    endDate: DateTime.utc(2030),
                    setDate: (value){
                      setState(() {
                        maturityDate = value;
                      });
                    },
                  ),
                  DropdownBorderInputWidget(
                    title: "Do you have a bulk sum saved toward this target",
                    textColor: AppColors.kPrimaryColor,
                    items: ["Yes", "No"],
                    onSelect: (value){
                      if(value == "Yes"){
                        setState(() {
                          haveBulkSum = true;
                        });
                      }else{
                        setState(() {
                          haveBulkSum = false;
                        });
                      }
                    },
                  ),
                  haveBulkSum ? AmountWidgetBorder(textColor: AppColors.kAccountTextColor,
                    onChange: (value){
                      setState(() {
                        bulkSum = value * 100;
                      });
                    },title: "How much is the available bulk sum",):SizedBox(),

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
                  YMargin(20),
                  Builder(
                    builder: (context){
                      return PrimaryButton(
                        title: "Calculate",
                        onPressed:(_planName != null && targetAmount != null &&
                            maturityDate != null && haveBulkSum != null && frequency != null) ? ()async{
                          EasyLoading.show(status: "loading");

                            var result = await savingViewModel.calculateTargetSavings(
                              token: identityViewModel.user.token,
                              targetAmount: targetAmount,
                              frequency: frequency.id,
                              isBulkSum: haveBulkSum,
                              bulkSum: bulkSum,
                              maturityDate: maturityDate
                            );
                            if(result.error == false){
                              EasyLoading.showSuccess("success",
                                  duration: Duration(seconds: 2));
                              setState(() {
                                aspireTarget = result.data;
                              });
                              showTargetValue(context);
                            }else{
                              EasyLoading.showError(result.errorMessage,
                                  duration: Duration(seconds: 2));
                            }
                          }:null

                      );
                    },

                  ),
                ],
              ),
            ),
          ):Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  FixedAmountWidgetBorder(
                    textColor: AppColors.kAccountTextColor,
                    value: FlutterMoneyFormatter(amount: aspireTarget.requiredAmount.toDouble()).output.nonSymbol,
                   title: "How much will you like to save frequently",
                  ),

                  DateOfBirthBorderInputWidget(
                    startDate: DateTime.now(),
                    initialDate: DateTime.now(),
                    selected: startDate,
                    endDate: maturityDate.subtract(Duration(days: 93)),
                    setDate: (value){
                      setState(() {
                        startDate = value;
                      });
                    },
                    title: "Start Date",textColor: AppColors.kAccountTextColor,
                  ),
                  IgnorePointer(
                    child: DateOfBirthBorderInputWidget(
                      key: Key("ppp"),
                      startDate: DateTime.now().add(Duration(days: 90)),
                      selected: maturityDate,
                      initialDate: DateTime.now().add(Duration(days: 90)),
                      endDate: DateTime.utc(2030),
                      setDate: (value){
                        setState(() {
                          maturityDate = value;
                        });
                      },
                      title: "End Date",textColor: AppColors.kAccountTextColor
                      ,),
                  ),
                  DropdownBorderInputWidget(
                    key: Key("pppe"),
                    title: "Select Funding source",
                    textColor: AppColors.kPrimaryColor,
                    onSelect: (value) {
                      print("koo ${value}");
                      setState(() {
                        fundingChannel = savingViewModel.fundingChannels
                            .firstWhere((element) => element.name == value);
                        print("koo ${fundingChannel.id}");
                        _hasFunds = fundingChannel.name == "Wallet" ?
                        true :
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
                    builder: (context){
                      return PrimaryButton(
                        title: "Create Plan",
                        onPressed: (startDate != null &&
                            maturityDate != null  && fundingChannel != null && _agreed == true) ? ()async{
                          EasyLoading.show(status: "loading");

                          var result = await savingViewModel.createTargetSavings(
                              token: identityViewModel.user.token,
                              targetAmount: targetAmount,
                              frequency: frequency.id,
                              cardId: paymentViewModel.userCards.first.id,
                              maturityDate: maturityDate,
                              startDate: startDate,
                            productId: 2,
                            savingsAmount: aspireTarget.requiredAmount,
                            fundingChannel: fundingChannel.id,
                            planName: _planName
                          );
                          print("kkkkk ${result.error} -- ${result.errorMessage}");
                          if(result.error == false){
                            EasyLoading.showSuccess(result?.errorMessage ??"success",
                                duration: Duration(seconds: 2));
                            Navigator.of(context).pop();
                          }else{
                            EasyLoading.showError(result.errorMessage,
                                duration: Duration(seconds: 2));
                          }
                        }:null,
                      );
                    },

                  ),
                ],
              ),
            ),
          )
        ],),
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

  void showTargetValue(BuildContext context) {
    showModalBottomSheet(
      isDismissible: false,
        context: context, builder: (context){
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
        height: 260,
        color: AppColors.kLightBG,
        child: Column(
          children: [
          Row(children: [
            Spacer(),
            InkWell(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: SvgPicture.asset("images/round_close.svg"),
              ),
            ),
    
          ],),
            YMargin(27),
            RichText(
              text: TextSpan(
                  children: [
                TextSpan(text:  aspireTarget.message,
                    style: TextStyle(fontFamily: "Caros",color: AppColors.kPrimaryColor)),
              ], ),textAlign: TextAlign.center,
            ),
            YMargin(33),
            Row(
              children: [
                Expanded(child: OutlinePrimaryButton(
                  title: "Cancel",
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                ),),
                XMargin(20),
                Expanded(child: PrimaryButton(
                  title: "Yes, Please",
                  onPressed: (){
                      Navigator.of(context).pop();
                      setState(() {
                        _progress = 1;
                      });
                  },
                ),)
              ],
            )
        ],),
      );
    });
  }
}


