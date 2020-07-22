import 'package:flutter/material.dart';
import 'package:zimvest/screens/tabs/home.dart';
import 'package:zimvest/screens/tabs/invstment/investment_screen.dart';
import 'package:zimvest/screens/tabs/savings/savings_screen.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/widgets/bottom_nav.dart';

class ScreenContainer extends StatefulWidget {
  final bool newSignUp;
  final Function handleMoreClicked;

  const ScreenContainer({Key key, this.newSignUp, this.handleMoreClicked}) : super(key: key);
  static Route<dynamic> route({bool newSignUp = false, Function handleMoreClicked }) {
    return MaterialPageRoute(
        builder: (_) => ScreenContainer(newSignUp: newSignUp,handleMoreClicked: handleMoreClicked,),
        settings: RouteSettings(name: ScreenContainer().toStringShort()));
  }
  @override
  _ScreenContainerState createState() => _ScreenContainerState();
}

class _ScreenContainerState extends State<ScreenContainer> {

  bool isCollapsed = true;
  double screenWidth, screenHieght;

  List<Widget> _screenWidgetList = [
    DashboardScreen(),
    SavingsScreen(),
    InvestmentScreen()
  ];



  // initial index of the bottom nav
  int _currentIndex = 0;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20)
    ),
        child: Stack(
          children: [
            _screenWidgetList.elementAt(_currentIndex),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Material(
                elevation: 10,
                child: Container(
                  height: 80,
                  color: AppColors.kPrimaryColor,
                  padding: EdgeInsets.only(top: 20,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      BottomNavEntry(
                        onTap: (){
                          setState(() {
                            _currentIndex = 0;
                          });
                        },
                        title: 'Dashboard',
                        image : "home",
                        isSelected: _currentIndex == 0 ? true : false,
                      ),

                      BottomNavEntry(
                        onTap: (){
                          setState(() {
                            _currentIndex = 1;
                          });
                        },
                        title: 'Savings',
                        image : "savings",
                        isSelected: _currentIndex == 1 ? true : false,
                      ),

                      BottomNavEntry(
                        onTap: (){
                          setState(() {
                            _currentIndex = 2;
                          });
                        },
                        title: 'Investments',
                        image : "investments",
                        isSelected: _currentIndex == 2 ? true : false,
                      ),
                      BottomNavEntry(
                        onTap: widget.handleMoreClicked,
                        title: 'More',
                        image : "more",
                        isSelected: _currentIndex == 2 ? true : false,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        )
    );
  }
}

