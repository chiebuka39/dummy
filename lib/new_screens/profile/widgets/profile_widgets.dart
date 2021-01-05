import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    Key key, this.emergency = false,
    this.title, this.onClick,
    this.icon, this.padding = 20,
    this.approved = false, this.pending= false,
    this.rejected= false, this.showNext = true,
  }) : super(key: key);

  final bool emergency;
  final bool approved;
  final bool pending;
  final bool rejected;
  final bool showNext;
  final double padding;
  final String icon;
  final String title;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: padding),
        margin: EdgeInsets.only(top: 20),
        height: 40,
        child: Row(children: [
          icon == null ? SizedBox():Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SvgPicture.asset("images/new/$icon.svg"),
          ),

          Text(title, style: TextStyle(fontSize: 13, fontFamily: AppStrings.fontNormal),),
          Spacer(),
          emergency ? SvgPicture.asset("images/new/emergency.svg"):
          SizedBox(),
          XMargin(5),
          approved == true ? Container(
            height: 20,
            width: 57,
            decoration: BoxDecoration(
                color: AppColors.kGreen1.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Center(child: Text("Approved", style: TextStyle(fontSize: 9,
                color: AppColors.kGreen1),),),
          ):SizedBox(),
          pending == true ? Container(
            height: 20,
            width: 90,
            decoration: BoxDecoration(
                color: AppColors.kPending.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Center(child: Text("Pending Approval", style: TextStyle(fontSize: 9,
                color: AppColors.kPending),),),
          ):SizedBox(),
          rejected == true ? Container(
            height: 20,
            width: 57,
            decoration: BoxDecoration(
                color: AppColors.kRejected.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Center(child: Text("Rejected", style: TextStyle(fontSize: 9,
                color: AppColors.kRejected),),),
          ):SizedBox(),
          showNext == true ?Icon(Icons.navigate_next, color: AppColors.kPrimaryColor,):SizedBox(),
        ],),
      ),
    );
  }
}