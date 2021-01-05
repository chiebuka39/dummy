import 'package:flutter/material.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

class IdentityUploadScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => IdentityUploadScreen(),
        settings:
        RouteSettings(name: IdentityUploadScreen().toStringShort()));
  }
  @override
  _IdentityUploadScreenState createState() => _IdentityUploadScreenState();
}

class _IdentityUploadScreenState extends State<IdentityUploadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ZimAppBar(
        text: "Identity Document",
        callback: (){
          Navigator.of(context).pop();
        },
        icon: Icons.arrow_back_ios,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          YMargin(60),
          Text("Choose ID option", style: TextStyle(
            fontSize: 13,fontFamily: AppStrings.fontMedium
          ),),

          IdentityWidget(),
          IdentityWidget(title: 'National identity card',),
          IdentityWidget(title: 'International passport',),
          IdentityWidget(title: 'Driver’s license',),
        ],),
      ),
    );
  }
}

class IdentityWidget extends StatelessWidget {
  const IdentityWidget({
    Key key, this.title = "Permanent Voters Card", this.onTap,
  }) : super(key: key);

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(top: 29),
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.kSecondaryColor
        ),
        child: Row(children: [
          Text(title, style: TextStyle(color: AppColors.kWhite),),
          Spacer(),
          Icon(Icons.navigate_next, color: AppColors.kWhite,)
        ],),
      ),
    );
  }
}
