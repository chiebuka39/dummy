import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';

class ZimAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String desc;
  const ZimAppBar({
    Key key, this.title = "Create new Zimvest Aspire", this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: desc == null? 140: desc.length < 100 ? 170: 220,
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
                InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    child: Row(children: [
                      XMargin(20),
                      Icon(Icons.arrow_back_ios, color: AppColors.kAccentColor,size: 18,),
                      XMargin(3),
                      Text("Go back",style: TextStyle(fontSize: 12, color: AppColors.kAccentColor),)
                    ],),
                  ),
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
              child: Text(title, style: TextStyle(fontFamily: "Caros-Bold", fontSize: 16),),
            ),
            YMargin(11),
            desc == null ? SizedBox():Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(desc,
                style: TextStyle(
                    fontSize: 10,
                    color: AppColors.kAccountTextColor,
                    height: 1.5
                ),),
            )

          ],),
      ),
    );
  }

  @override

  Size get preferredSize => Size.fromHeight(desc == null? 140: 220);
}
class ZimAppBarWitButton extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String desc;
  final VoidCallback onTap;
  const ZimAppBarWitButton({
    Key key, this.title = "Create new Zimvest Aspire", this.desc, this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: desc == null? 140: desc.length < 100 ? 170: 220,
      decoration: BoxDecoration(
        boxShadow: AppUtils.getBoxShaddow2,
        color: AppColors.kWhite,
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YMargin(5),
            Row(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    child: Row(children: [
                      XMargin(20),
                      Icon(Icons.arrow_back_ios, color: AppColors.kAccentColor,size: 18,),
                      XMargin(3),
                      Text("Go back",style: TextStyle(fontSize: 12, color: AppColors.kAccentColor),)
                    ],),
                  ),
                ),
                Spacer(),
                FlatButton(
                  child: Text("Calculate", style: TextStyle(fontSize: 12, color: AppColors.kAccentColor),),
                  onPressed: onTap,
                ),
              ],
            ),
            YMargin(15),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(title, style: TextStyle(fontFamily: "Caros-Bold", fontSize: 16),),
            ),
            YMargin(11),
            desc == null ? SizedBox():Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(desc,
                style: TextStyle(
                    fontSize: 10,
                    color: AppColors.kAccountTextColor,
                    height: 1.5
                ),),
            )

          ],),
      ),
    );
  }

  @override

  Size get preferredSize => Size.fromHeight(desc == null? 140: 220);
}