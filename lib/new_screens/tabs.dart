import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/models/payment/wallet.dart';
import 'package:zimvest/data/view_models/dashboard_view_model.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
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

class TabsContainer extends StatefulWidget {
  const TabsContainer({Key key}) : super(key: key);
  static Route<dynamic> route(
      {bool newSignUp = false, Function handleMoreClicked}) {
    return MaterialPageRoute(
      builder: (_) => TabsContainer(),
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

    dashboardViewModel.getPortfolioValue(identityViewModel.user.token);
    savingViewModel.getSavingPlans(token: identityViewModel.user.token);
    paymentViewModel.getWallet(identityViewModel.user.token);
    settingsViewModel.getCompletedSections(token: identityViewModel.user.token);

  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    identityViewModel = Provider.of(context);
    dashboardViewModel = Provider.of(context);
    savingViewModel = Provider.of(context);
    paymentViewModel = Provider.of(context);
    settingsViewModel = Provider.of(context);
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
