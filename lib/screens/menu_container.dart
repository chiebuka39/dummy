import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zimvest/screens/account/account_settings_screen.dart';
import 'package:zimvest/screens/banks_cards/manage_banks_cards.dart';
import 'package:zimvest/screens/my_planner/target_planner.dart';
import 'package:zimvest/screens/tabs.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';

class MenuContainer extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => MenuContainer(),
        settings: RouteSettings(name: MenuContainer().toStringShort()));
  }

  @override
  _MenuContainerState createState() => _MenuContainerState();
}

class _MenuContainerState extends State<MenuContainer> {
  bool isCollapsed = false;
  double screenWidth, screenHeight;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: AppColors.kPrimaryColor,
            child: SafeArea(
              child: Column(
                children: [
                  YMargin(5),
                  Row(
                    children: [
                      XMargin(20),
                      CircularProfileAvatar(
                        AppStrings.avatar,
                        radius: 17,
                      ),
                      XMargin(18),
                      Text(
                        "Marie Mathews",
                        style: TextStyle(color: AppColors.kWhite, fontSize: 15),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            isCollapsed = !isCollapsed;
                          });
                        },
                      )
                    ],
                  ),
                  YMargin(0.08 * screenHeight),
                  SideMenuItem(
                    icon: "investments",
                    title: "Investments",
                    left: 0.4 * screenWidth,
                  ),
                  SideMenuItem(
                    icon: "planner",
                    title: "My Planner",
                    top: 25,
                    left: 0.4 * screenWidth,
                    onTap: () {
                      Navigator.of(context).push(TargetCalculator.route());
                    },
                  ),
                  SideMenuItem(
                      icon: "persona",
                      title: "Investment Persona Analysis",
                      top: 25,
                      left: 0.4 * screenWidth),
                  SideMenuItem(
                      icon: "service",
                      title: "Service Request",
                      top: 25,
                      left: 0.4 * screenWidth),
                  SideMenuItem(
                    icon: "cards",
                    title: "Cards and banks",
                    top: 25,
                    left: 0.4 * screenWidth,
                    onTap: () {
                      Navigator.of(context).push(ManageCardsAndBank.route());
                    },
                  ),
                  Spacer(),
                  SideMenuItem(
                    icon: "account",
                    title: "Account Settings",
                    top: 25,
                    left: 0.4 * screenWidth,
                    onTap: () {
                      Navigator.of(context).push(AccountSettingScreen.route());
                    },
                  ),
                  SideMenuItem(
                      icon: "security",
                      title: "Security Settings",
                      top: 25,
                      left: 0.4 * screenWidth),
                  SideMenuItem(
                    icon: "logout",
                    title: "Logout",
                    top: 25,
                    left: 0.4 * screenWidth,
                    color: AppColors.kRed,
                  ),
                  YMargin(20)
                ],
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            top: 0.18 * screenHeight,
            bottom: 0.18 * screenHeight,
            left: -0.5 * screenWidth,
            right: 0.67 * screenWidth,
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.kLightTitleText,
                  borderRadius: BorderRadius.circular(15)),
            ),
          ),
          AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              top: isCollapsed ? 0.15 * screenHeight : 0,
              bottom: isCollapsed ? 0.15 * screenHeight : 0,
              left: isCollapsed ? -0.5 * screenWidth : 0,
              right: isCollapsed ? 0.7 * screenWidth : 0,
              child: ScreenContainer(
                newSignUp: false,
                handleMoreClicked: () {
                  setState(() {
                    isCollapsed = !isCollapsed;
                  });
                },
              ))
        ],
      ),
    );
  }
}

class SideMenuItem extends StatelessWidget {
  final String title;
  final String icon;
  final double top;
  final double left;
  final Color color;
  final VoidCallback onTap;
  const SideMenuItem({
    Key key,
    this.title,
    this.icon,
    this.top = 0,
    this.left = 200,
    this.color = AppColors.kWhite,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: top),
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            XMargin(left),
            SvgPicture.asset(
              "images/$icon.svg",
              color: color,
            ),
            XMargin(5),
            SizedBox(
                width: 140,
                child: Text(
                  title,
                  style: TextStyle(color: color),
                ))
          ],
        ),
      ),
    );
  }
}
