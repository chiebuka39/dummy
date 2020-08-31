import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/dashboard_view_model.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/screens/tabs/home.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/styles/styles.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/home/assets_distribution.dart';

class HeaderPage extends StatefulWidget {
  const HeaderPage({
    Key key,
    @required this.amount,
    this.moveToPrev,
    this.moveToNext,
    this.title = "My Dollar portfolio balance", this.bg = "layer_2", this.showLastWidget = true,
  }) : super(key: key);


  final String amount;
  final VoidCallback moveToPrev;
  final VoidCallback moveToNext;
  final String title;
  final String bg;
  final bool showLastWidget;

  @override
  _HeaderPageState createState() => _HeaderPageState();
}

class _HeaderPageState extends State<HeaderPage> {
  ABSDashboardViewModel dashboardViewModel;

  @override
  Widget build(BuildContext context) {
    ABSIdentityViewModel identityViewModel = Provider.of(context);
    dashboardViewModel = Provider.of(context);
    return Container(
      height: 255,
      width: double.infinity,
      decoration: BoxDecoration(color: widget.bg == "header_bg"?AppColors.kAccentColor: AppColors.kPrimaryColor),
      child: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              child: Image.asset(
                "images/${widget.bg}.png",
                width: double.infinity,
              )),
          SafeArea(
            child: Column(
              children: [
                YMargin(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome back",
                            style: TextStyle(
                                fontSize: 16, color: AppColors.kWhite),
                          ),
                          Text(
                            identityViewModel.user.fullname.split(" ").first,
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Caros-Medium",
                                color: AppColors.kWhite),
                          ),
                        ],
                      ),
                      Spacer(),
                      NotificationIdentifier(),
                      XMargin(12),
                      CircularProfileAvatar(
                        AppStrings.avatar,
                        radius: 17,
                      )
                    ],
                  ),
                ),
                YMargin(25),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white.withOpacity(widget.moveToPrev ==null ? 0:0.5),
                        size: 18,
                      ),
                      onPressed: widget.moveToPrev,
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                              color: widget.bg == "header_bg"?AppColors.kPrimaryColor2: AppColors.kLightTitleText, fontSize: 13),
                        ),
                        YMargin(5),
                        Text(
                          widget.amount,
                          style: TextStyle(
                              fontFamily: "Caros-Bold",
                              color: AppColors.kWhite,
                              fontSize: 27),
                        ),
                      ],
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white.withOpacity(widget.moveToNext == null ?0:0.5),
                        size: 18,
                      ),
                      onPressed: widget.moveToNext,
                    ),
                  ],
                ),
                YMargin(15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text(
                        "Accrued Interest",
                        style: AppStyles.tinyTitle,
                      ),
                      XMargin(10),
                      Text(
                        widget.amount,
                        style: TextStyle(
                            color: AppColors.kWhite,
                            fontSize: 12,
                            fontFamily: "Caros-Bold"),
                      ),
                      Spacer(),
                      InkWell(onTap: (){
                        showGraphs(context);
                      }, child: Row(children: [
                        Text("View Breakdown", style: TextStyle(fontSize: 10),),
                        Icon(Icons.arrow_forward_ios,size: 15,)
                      ],))
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showGraphs(BuildContext context) {
    showCupertinoModalBottomSheet(context: context, builder: (context, controller){
      return Container(

        child: Scaffold(
          body: Column(children: [
            YMargin(20),
            Row(
              children: [
                IconButton(icon: Icon(Icons.navigate_before),
                    onPressed: (){

                    }),
                Spacer(),
                Text("Portfolio Distribution", style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Caros-Bold",
                    color: AppColors.kPrimaryColor2
                ),),
                Spacer(),
                IconButton(icon: Icon(Icons.navigate_next),
                    onPressed: (){

                    }),
              ],
            ),
            buildDonut(dashboardViewModel),
            Container(
              height: 67,
              width: double.infinity,
              color: Color(0xFFF4F4F4),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    decoration: BoxDecoration(
                      color: AppColors.donutColor[0]
                    ),
                  ),
                  XMargin(26),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text("Fixed Income", style: TextStyle(
                                fontFamily: "Caros-Bold", fontSize: 12),),
                            Spacer(),
                            Text("50%", style: TextStyle(color: AppColors.kPrimaryColor2,fontSize: 12, fontFamily: "Caros-Bold"),),
                            XMargin(30)
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 7),
                          child: Text("\u20A6 3,000,000", style: TextStyle(fontSize: 12),),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],),
        ),
      );

    });
  }
}