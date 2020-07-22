import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/account_widgets.dart';
import 'package:zimvest/widgets/buttons.dart';

class KinCreateZimvestAspireScreenTwo extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => KinCreateZimvestAspireScreenTwo(),
        settings: RouteSettings(name: KinCreateZimvestAspireScreenTwo().toStringShort()));
  }
  @override
  _KinCreateZimvestAspireScreenTwoState createState() => _KinCreateZimvestAspireScreenTwoState();
}

class _KinCreateZimvestAspireScreenTwoState extends State<KinCreateZimvestAspireScreenTwo> {
  bool haveBulkSum = false;
  bool selectedOthers = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FBFB),
      body: Column(children: [
        Container(
          height: 170,
          decoration: BoxDecoration(
            boxShadow: AppUtils.getBoxShaddow2,
            color: AppColors.kWhite,
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YMargin(15),
                Row(
                  children: [
                    Container(
                      child: Row(children: [
                        XMargin(20),
                        Icon(Icons.arrow_back_ios, color: AppColors.kAccentColor,size: 18,),
                        XMargin(3),
                        Text("Go back",style: TextStyle(fontSize: 12, color: AppColors.kAccentColor),)
                      ],),
                    ),
                    Spacer(),
                    CircularProfileAvatar(
                      AppStrings.avatar,
                      radius: 17,
                    ),
                    XMargin(20)
                  ],
                ),
                YMargin(15),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text("Create new Zimvest Aspire", style: TextStyle(fontFamily: "Caros-Bold", fontSize: 16),),
                ),
                YMargin(11),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Our Zimvest Aspire plan allows you to conveniently "
                      "save a mimimum amount of ₦1000, either daily, "
                      "weekly or monthly for as long as you "
                      "want and get an interest of 14%",
                    style: TextStyle(
                        fontSize: 10,
                        color: AppColors.kAccountTextColor,
                        height: 1.5
                    ),),
                )

              ],),
          ),
        ),
        Expanded(
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
