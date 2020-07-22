import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  int _progress = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FBFB),
      body: Column(children: [
        ZimAppBar(desc:  "Our Zimvest Aspire plan allows you to conveniently "
            "save a mimimum amount of ₦1000, either daily, "
            "weekly or monthly for as long as you "
            "want and get an interest of 14%",),
        _progress == 0 ?Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                DropdownBorderInputWidget(
                  title: "Plan Name",
                  textColor: AppColors.kPrimaryColor,
                  items: ["Car", "Pick up","Others"],
                ),
                selectedOthers ? TextWidgetBorder(title: "Custom Plan name",
                  textColor: AppColors.kAccountTextColor,):SizedBox(),
                AmountWidgetBorder(textColor: AppColors.kAccountTextColor,
                  onChange: (value){},title: "Target amount",),
                DateOfBirthBorderInputWidget(title: "Maturity Date",textColor: AppColors.kAccountTextColor,),
                DropdownBorderInputWidget(
                  title: "Do you have a bulk sum saved toward this target",
                  textColor: AppColors.kPrimaryColor,
                  items: ["Yes", "No"],
                ),
                haveBulkSum ? AmountWidgetBorder(textColor: AppColors.kAccountTextColor,
                  onChange: (value){},title: "How much is the available bulk sum",):SizedBox(),

                DropdownBorderInputWidget(
                  title: "How often would you like to save",
                  textColor: AppColors.kPrimaryColor,
                  items: ["Monthly", "Daily", "Weekly"],
                ),
                YMargin(20),
                Builder(
                  builder: (context){
                    return PrimaryButton(
                      title: "Calculate",
                      onPressed: (){
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
                                    TextSpan(text: 'For this target, '
                                        'you will need to save a monthly sum of ',
                                        style: TextStyle(fontFamily: "Caros",color: AppColors.kPrimaryColor)),
                                    TextSpan(text: '#50,000',
                                        style: TextStyle(fontFamily: "Caros-Bold",color: AppColors.kPrimaryColor)),
                                    TextSpan(text: ' at the rate of',
                                        style: TextStyle(fontFamily: "Caros",color: AppColors.kPrimaryColor)),
                                    TextSpan(text: ' 10%',
                                        style: TextStyle(fontFamily: "Caros-Bold",color: AppColors.kPrimaryColor)),
                                    TextSpan(text: ' for a period of',
                                        style: TextStyle(fontFamily: "Caros",color: AppColors.kPrimaryColor)),
                                    TextSpan(text: ' 12 months',
                                        style: TextStyle(fontFamily: "Caros-Bold",color: AppColors.kPrimaryColor)),
                                    TextSpan(text: '\n \nWould you like to continue?',
                                        style: TextStyle(fontFamily: "Caros-Bold",color: AppColors.kPrimaryColor)),
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
                      },
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
                AmountWidgetBorder(textColor: AppColors.kAccountTextColor,
                  onChange: (value){},title: "How much will you like to save frequently",),
                DateOfBirthBorderInputWidget(title: "Start Date",textColor: AppColors.kAccountTextColor,),
                DateOfBirthBorderInputWidget(title: "End Date",textColor: AppColors.kAccountTextColor,),
                DropdownBorderInputWidget(
                  title: "Select Funding source",
                  textColor: AppColors.kPrimaryColor,
                  items: ["Car", "Pick up","Others"],
                ),

                YMargin(20),
                Builder(
                  builder: (context){
                    return PrimaryButton(
                      title: "Calculate",
                      onPressed: (){
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
                                      TextSpan(text: 'For this target, '
                                          'you will need to save a monthly sum of ',
                                          style: TextStyle(fontFamily: "Caros",color: AppColors.kPrimaryColor)),
                                      TextSpan(text: '#50,000',
                                          style: TextStyle(fontFamily: "Caros-Bold",color: AppColors.kPrimaryColor)),
                                      TextSpan(text: ' at the rate of',
                                          style: TextStyle(fontFamily: "Caros",color: AppColors.kPrimaryColor)),
                                      TextSpan(text: ' 10%',
                                          style: TextStyle(fontFamily: "Caros-Bold",color: AppColors.kPrimaryColor)),
                                      TextSpan(text: ' for a period of',
                                          style: TextStyle(fontFamily: "Caros",color: AppColors.kPrimaryColor)),
                                      TextSpan(text: ' 12 months',
                                          style: TextStyle(fontFamily: "Caros-Bold",color: AppColors.kPrimaryColor)),
                                      TextSpan(text: '\n \nWould you like to continue?',
                                          style: TextStyle(fontFamily: "Caros-Bold",color: AppColors.kPrimaryColor)),
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

                                      },
                                    ),)
                                  ],
                                )
                              ],),
                          );
                        });
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


