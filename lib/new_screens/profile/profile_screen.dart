import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zimvest/new_screens/profile/account_screen.dart';
import 'package:zimvest/new_screens/profile/widgets/profile_widgets.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';

class ProfileScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => ProfileScreen(),
        settings:
        RouteSettings(name: ProfileScreen().toStringShort()));
  }
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color:AppColors.kTextColor),
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(icon: Icon(Icons.close, color: AppColors.kPrimaryColor,), onPressed: () {
            Navigator.pop(context);
          },),
        ),
        title: Text("Profile", style: TextStyle(fontSize: 13,
            fontFamily: AppStrings.fontMedium,color: AppColors.kTextColor),),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          YMargin(30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                SvgPicture.asset("images/new/account.svg", width: 57,),
                XMargin(20),
                Text("Emmanuel West", style: TextStyle(fontFamily: AppStrings.fontMedium),)
              ],
            ),
          ),
          YMargin(29),
          ProfileWidget(emergency: true,title: "Account",onClick: (){
            Navigator.push(context, AccountScreen.route());
          },icon: 'account',),
          ProfileWidget(title: "Notifications",icon: 'notif',),
          ProfileWidget(title: "Banks & Cards",icon: 'cards',),
          ProfileWidget(title: "Security",icon: 'security',),
          ProfileWidget(title: "Investment Persona Analysis",icon: 'ips',),
          ProfileWidget(title: "Earn Free Cash",icon: 'earn',),
          ProfileWidget(title: "Rate App",icon: 'rate',),
          ProfileWidget(title: "About Zimvest",icon: 'about',),
          ProfileWidget(title: "Log Out",icon: 'log-out',),
        ],),
      ),
    );
  }
}


