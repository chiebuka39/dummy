import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/models/payment/wallet.dart';
import 'package:zimvest/data/view_models/dashboard_view_model.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/data/view_models/savings_view_model.dart';
import 'package:zimvest/data/view_models/settings_view_model.dart';
import 'package:zimvest/new_screens/navigation/WalletScreen.dart';
import 'package:zimvest/new_screens/navigation/home_screen.dart';
import 'package:zimvest/new_screens/navigation/portfolio_screen.dart';
import 'package:zimvest/new_screens/navigation/wealth_screen.dart';
import 'package:zimvest/new_screens/navigation/transactions_screen.dart';
import 'package:zimvest/screens/tabs/home/home.dart';
import 'package:zimvest/screens/tabs/invstment/investment_screen.dart';
import 'package:zimvest/screens/tabs/savings/savings_screen.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/widgets/bottom_nav.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

class TabsContainer extends StatefulWidget {
  final int tab;
  const TabsContainer({
    Key key,
    this.tab = 0}) : super(key: key);
  static Route<dynamic> route(
      {bool newSignUp = false, Function handleMoreClicked, int tab = 0}) {
    return MaterialPageRoute(
      builder: (_) => TabsContainer(tab: tab,),
      settings: RouteSettings(
        name: TabsContainer().toStringShort(),
      ),
    );
  }

  @override
  _TabsContainerState createState() => _TabsContainerState();
}

class _TabsContainerState extends State<TabsContainer>
    with AfterLayoutMixin<TabsContainer> {
  ABSDashboardViewModel dashboardViewModel;
  ABSIdentityViewModel identityViewModel;
  ABSSettingsViewModel settingsViewModel;
  ABSSavingViewModel savingViewModel;
  ABSPaymentViewModel paymentViewModel;

  BuildContext context1;

  List<Widget> _screenWidgetList = [
    HomeScreen(),
    WealthScreen(),
    PortfolioScreen(),
    TransactionsScreen(),
    WalletScreen(),
  ];



  // initial index of the bottom nav
  int _currentIndex = 0;



  @override
  void afterFirstLayout(BuildContext context) async{
    _screenWidgetList[0] = HomeScreen(callback: (){
      setState(() {
        _currentIndex = 4;
      });
    },);
    dashboardViewModel.callback = (){

      setState(() {
        _currentIndex = 1;
      });
    };
    setState(() {

    });

    dashboardViewModel.getPortfolioValue(identityViewModel.user.token).then((value) {
      print("jjjjjjjj<<<<<<<<<<<<<");
      if(value.networkAvailable == false){
        showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
          return NoInternetWidget(onDone: (){
            Navigator.pop(context);
            Navigator.pop(context);
          },message: "Your Upload was successfully",);
        });
      }
    });
    savingViewModel.getSavingPlans(token: identityViewModel.user.token);
    paymentViewModel.getWallet(identityViewModel.user.token);
    settingsViewModel.getCompletedSections(token: identityViewModel.user.token);

  }

  @override
  void initState() {
    _currentIndex = widget.tab;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    identityViewModel = Provider.of(context);
    dashboardViewModel = Provider.of(context);
    savingViewModel = Provider.of(context);
    paymentViewModel = Provider.of(context);
    settingsViewModel = Provider.of(context);
    print("00000kkk $_currentIndex");
    return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
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
                  color: AppColors.kBottomNav,
                  padding: EdgeInsets.only(
                    top: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      BottomNavEntry(
                        onTap: () {
                          setState(() {
                            _currentIndex = 0;
                          });
                        },
                        title: 'Home',
                        image: "home",
                        isSelected: _currentIndex == 0 ? true : false,
                      ),
                      BottomNavEntry(
                        onTap: () {
                          setState(() {
                            _currentIndex = 1;
                          });
                        },
                        title: 'Wealth',
                        image: "wealth",
                        isSelected: _currentIndex == 1 ? true : false,
                      ),
                      BottomNavEntry(
                        onTap: () {
                          setState(() {
                            _currentIndex = 2;
                          });
                        },
                        title: 'Portfolio',
                        image: "prtfolio",
                        isSelected: _currentIndex == 2 ? true : false,
                      ),
                      BottomNavEntry(
                        onTap: () {
                          setState(() {
                            _currentIndex = 3;
                          });
                        },
                        title: 'Transactions',
                        image: "transactions",
                        isSelected: _currentIndex == 3 ? true : false,
                      ),
                      BottomNavEntry(
                        onTap: () {
                          setState(() {
                            _currentIndex = 4;
                          });
                        },
                        title: 'Wallet',
                        image: "wallet",
                        isSelected: _currentIndex == 4 ? true : false,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
