import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:zimvest/data/models/saving_plan.dart';
import 'package:zimvest/new_screens/navigation/wealth/aspire/select_goals.dart';
import 'package:zimvest/new_screens/navigation/wealth/aspire_box_details.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';

class AspireContainerWidget extends StatelessWidget {
  const AspireContainerWidget({
    Key key,
    this.goal,
  }) : super(key: key);
  final SavingPlanModel goal;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, AspireDetailsScreen.route(goal));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 154,
              decoration: BoxDecoration(
                  color: AppColors.kGreyBg,
                  borderRadius: BorderRadius.circular(13)),
              child: Stack(
                children: [
                  Hero(
                    tag: goal,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(13),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://firebasestorage.googleapis.com/v0/b/tick-bc0e3.appspot.com/o/pexels-anete-lusina-5723322.'
                            'jpg?alt=media&token=4858ef91-820b-4ff3-aae7-a02ce3507c6d',
                        height: 154,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        color: Colors.black.withOpacity(0.2)),
                  ),
                  Positioned.fill(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Spacer(),
                          Row(
                            children: [
                              Spacer(),
                              CircularPercentIndicator(

                                radius: 35.0,
                                lineWidth: 3.0,
                                animation: true,
                                backgroundColor: Colors.transparent,
                                percent: (double.parse(goal.successRate
                                                .replaceAll("%", "")) /
                                            100) >
                                        1
                                    ? 1.0
                                    : (double.parse(goal.successRate
                                            .replaceAll("%", "")) /
                                        100),
                                //percent: 0.2,
                                center: new Text(
                                  "${goal.successRate}",
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 8,
                                      color: AppColors.kWhite),
                                ),
                                circularStrokeCap: CircularStrokeCap.round,
                                progressColor: AppColors.kWhite,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            YMargin(10),
            Text(
              goal.planName,
              style: TextStyle(
                  fontSize: 13,
                  fontFamily: AppStrings.fontMedium,
                  color: AppColors.kGreyText),
            ),
            YMargin(8),


            Row(
              children: [
                Text(AppStrings.nairaSymbol),
                Text(
                  "${goal.amountSaved}".split(".").first.convertWithComma(),
                  style: TextStyle(fontFamily: AppStrings.fontMedium, fontSize: 12),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AspireNewGoalWidget extends StatelessWidget {
  const AspireNewGoalWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, SelectGoalScreen.route());
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          height: 154,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(13)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset("images/new/Addd.svg"),
              Text(
                "Create New Goal",
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: AppStrings.fontMedium,
                    color: AppColors.kPrimaryColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AspireContainerWidgetTwo extends StatelessWidget {
  const AspireContainerWidgetTwo({
    Key key,
    this.goal,
  }) : super(key: key);
  final SavingPlanModel goal;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, AspireDetailsScreen.route(goal));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 154,
              decoration: BoxDecoration(
                  color: AppColors.kGreyBg,
                  borderRadius: BorderRadius.circular(13)),
              child: Stack(
                children: [
                  Hero(
                    tag: goal,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(13),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://firebasestorage.googleapis.com/v0/b/tick-bc0e3.appspot.com/o/pexels-anete-lusina-5723322.'
                            'jpg?alt=media&token=4858ef91-820b-4ff3-aae7-a02ce3507c6d',
                        height: 154,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        color: Colors.black.withOpacity(0.2)),
                  ),
                  Positioned.fill(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Spacer(),
                          Row(
                            children: [
                              Spacer(),
                              CircularPercentIndicator(
                                radius: 35.0,
                                lineWidth: 3.0,
                                animation: true,
                                percent:
                                    (double.parse(goal.successRate) / 100) > 1
                                        ? 0.5
                                        : (double.parse(goal.successRate) /
                                            100),
                                //percent: 0.2,
                                center: new Text(
                                  "${goal.successRate}",
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 8,
                                      color: AppColors.kWhite),
                                ),
                                circularStrokeCap: CircularStrokeCap.round,
                                progressColor: AppColors.kPrimaryColor,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            YMargin(10),
            Text(
              goal.planName,
              style: TextStyle(
                  fontSize: 10,
                  fontFamily: AppStrings.fontNormal,
                  color: AppColors.kGreyText),
            ),
            YMargin(8),
            Text(
              "${AppStrings.nairaSymbol}${goal.amountSaved}",
              style: TextStyle(fontFamily: AppStrings.fontMedium, fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
