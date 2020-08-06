import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
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
        settings: RouteSettings(name: CreateZimvestWealthBoxScreen().toStringShort()));
  }
  @override
  _CreateZimvestWealthBoxScreenState createState() => _CreateZimvestWealthBoxScreenState();
}

class _CreateZimvestWealthBoxScreenState extends State<CreateZimvestWealthBoxScreen> {
  bool haveBulkSum = false;
  bool selectedOthers = false;

  ABSSavingViewModel savingViewModel;
  ABSIdentityViewModel identityViewModel;
  ABSPaymentViewModel paymentViewModel;

  SavingsFrequency frequency;
  FundingChannel fundingChannel;
  DateTime date;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    savingViewModel = Provider.of(context);
    identityViewModel = Provider.of(context);
    paymentViewModel = Provider.of(context);
    return Scaffold(
      backgroundColor: Color(0xFFF8FBFB),
      appBar: ZimAppBar(desc:  "Our Zimvest Aspire plan allows you to conveniently "
          "save a mimimum amount of ₦1000, either daily, "
          "weekly or monthly for as long as you "
          "want and get an interest of 14%",title: "Create New Zimvest Wealth Box",),
      body: Column(children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                DropdownBorderInputWidget(
                  title: "How often would you like to save",
                  textColor: AppColors.kPrimaryColor,
                  onSelect: (value){
                    setState(() {
                      frequency = savingViewModel.savingFrequency.firstWhere((element) => element.name == value);
                    });
                  },
                  items: savingViewModel.savingFrequency.map((e) => e.name).toList(),
                ),
                selectedOthers ? TextWidgetBorder(title: "Custom Plan name",
                  textColor: AppColors.kAccountTextColor,):SizedBox(),
                AmountWidgetBorder(textColor: AppColors.kAccountTextColor,

                  onChange: (value){
                    print("val ${controller.text}");
                  },title: "Target amount",),
                DateOfBirthBorderInputWidget(
                  title: "Start Date",
                  textColor: AppColors.kAccountTextColor,
                  setDate: (value){
                    setState(() {
                      date = value;
                    });
                  },
                ),
                DropdownBorderInputWidget(
                  title: "Funding source",
                  textColor: AppColors.kPrimaryColor,
                  onSelect: (value){
                    setState(() {
                      fundingChannel = savingViewModel.fundingChannels.firstWhere((element) => element.name == value);
                    });
                  },
                  items: savingViewModel.fundingChannels.map((e) => e.name).toList(),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 250,
                      child: Text("You dont have any fund in your wallet, click here to add fund",
                        style: TextStyle(fontSize: 13, color: AppColors.kAccountTextColor),),
                    ),
                  ],
                ),

YMargin(10),
                Row(children: [
                  Theme(
                    data: ThemeData(
                      unselectedWidgetColor: AppColors.kAccentColor
                    ),
                    child: Checkbox(onChanged: (bool value) {

                    }, value: false,
                     activeColor: AppColors.kAccentColor,
                    ),
                  ),
                  XMargin(15),
                  Expanded(
                    child: RichText(

                      text: TextSpan(
                        style: TextStyle(fontFamily: "Caros",
                          color: AppColors.kAccountTextColor, fontSize: 10, height: 1.5),
                        children: [
                          TextSpan(text: "I agree that I will "),
                          TextSpan(text: "50% of my interest accrued ",style: TextStyle(fontFamily: "Caros-Bold")),
                          TextSpan(text: "on this target savings if I fail to meet "),
                          TextSpan(text: "at least 70% ",style: TextStyle(fontFamily: "Caros-Bold")),
                          TextSpan(text: "of my target amount at the point of withdrawal."),
                        ]
                      ),
                    ),
                  ),
                ],),
                YMargin(20),
                Builder(
                  builder: (context){
                    return PrimaryButton(
                      title: "Create Plan",
                      onPressed: (){

                      },
                    );
                  },

                ),
              ],
            ),
          ),
        )
      ],),
    );
  }
}


