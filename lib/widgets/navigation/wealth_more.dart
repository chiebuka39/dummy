import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zimvest/data/models/saving_plan.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/navigation/delete_wealthbox.dart';
import 'package:zimvest/widgets/navigation/wealthbox_activity.dart';

class WealthMore extends StatelessWidget {
  const WealthMore({
    Key key, this.savingPlanModel, this.delete = true,
  }) : super(key: key);

  final SavingPlanModel savingPlanModel;
  final bool delete;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 330,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        children: [
          YMargin(10),
          Center(
            child: Container(
              width: 30,
              height: 5,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
            ),
          ),
          YMargin(20),
          Expanded(
              child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            child: SafeArea(
              child: Column(
                children: [
                  YMargin(20),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Start Date",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: AppStrings.fontNormal,
                                  color: AppColors.kGreyText),
                            ),
                            YMargin(10),
                            Text(
                              AppUtils.getReadableDate2(savingPlanModel.startDate),
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: AppStrings.fontMedium,
                                  color: AppColors.kGreyText),
                            )
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Maturity Date",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: AppStrings.fontNormal,
                                  color: AppColors.kGreyText),
                            ),
                            YMargin(10),
                            Text(
                              AppUtils.getReadableDate2(savingPlanModel?.maturityDate ?? getDate()),
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: AppStrings.fontMedium,
                                  color: AppColors.kGreyText),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 35),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Automation Status",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: AppStrings.fontNormal,
                                  color: AppColors.kGreyText),
                            ),
                            YMargin(10),
                            Text(
                              savingPlanModel.isPaused ? 'Paused':'Active',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: AppStrings.fontMedium,
                                  color: AppColors.kGreyText),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  delete ? GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      showModalBottomSheet<Null>(
                          context: context,
                          builder: (BuildContext context) {
                            return DeleteWealthbox(savingPlanModel: savingPlanModel,);
                          },
                          isScrollControlled: true);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          SvgPicture.asset('images/new/delete_plan.svg'),
                          XMargin(15),
                          Text(
                            "Close Plan",
                            style: TextStyle(fontFamily: AppStrings.fontNormal),
                          ),
                          Spacer(),
                          Icon(
                            Icons.navigate_next_rounded,
                            color: AppColors.kPrimaryColor,
                          )
                        ],
                      ),
                    ),
                  ):SizedBox(),
                  YMargin(30),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }

  DateTime getDate(){
    DateTime now = DateTime.now();
    List<DateTime> quaters = [DateTime(now.year,1),DateTime(now.year,4),
      DateTime(now.year,7),DateTime(now.year,10)];
    print(",,,,,,,,ooooo ${quaters.where((element) => element.microsecondsSinceEpoch >= now.microsecondsSinceEpoch)}");
    return quaters.where((element) => element.microsecondsSinceEpoch >= now.microsecondsSinceEpoch).first;
  }
}
