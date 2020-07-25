import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zimvest/animations/pop_up_menu.dart';
import 'package:zimvest/screens/banks_cards/new_bank_screen.dart';
import 'package:zimvest/screens/banks_cards/new_card_screen.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/widgets/appbars.dart';

class ManageCardsAndBank extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => ManageCardsAndBank(),
        settings: RouteSettings(name: ManageCardsAndBank().toStringShort()));
  }

  @override
  _ManageCardsAndBankState createState() => _ManageCardsAndBankState();
}

class _ManageCardsAndBankState extends State<ManageCardsAndBank>
    with SingleTickerProviderStateMixin {
  GlobalKey btnKey = GlobalKey();
  GlobalKey btnKey2 = GlobalKey();
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(() {
      print("sss ${_tabController.index}");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PopupMenu menu = setUpPopUp(context);

    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            if (_tabController.index == 0) {
              Navigator.of(context).push(NewCardScreen.route());
            } else {
              Navigator.of(context).push(NewBankScreen.route());
            }
          },
          backgroundColor: AppColors.kAccentColor,
        ),
      ),
      backgroundColor: AppColors.kLightBG,
      appBar: ZimAppBar(
        title: "Manage cards and banks",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            YMargin(20),
            Text(
              "Manage your cards and banks: cards are "
              "used for funding while banks are "
              "used for withdrawals.",
              style:
                  TextStyle(fontSize: 12, color: AppColors.kAccountTextColor),
            ),
            TabBar(
              controller: _tabController,
              labelColor: AppColors.kPrimaryColor2,
              unselectedLabelColor: AppColors.kLightTitleText,
              labelStyle: TextStyle(fontFamily: "Caros-Medium", fontSize: 12),
              unselectedLabelStyle:
                  TextStyle(fontFamily: "Caros", fontSize: 12),
              indicatorColor: AppColors.kAccentColor,
              indicatorWeight: 3,
              tabs: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    "Cards",
                  ),
                ),
                Text("Banks")
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListView(
                    children: [
                      AddedBankWidget(),
                      AddedBankWidget(),
                    ],
                  ),
                  ListView(
                    children: [
                      PaymentCard(),
                      PaymentCard(),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  PopupMenu setUpPopUp(BuildContext context) {
    PopupMenu.context = context;
    PopupMenu menu = PopupMenu(
        backgroundColor: AppColors.kPrimaryColor,
        lineColor: AppColors.kLightTitleText,
        items: [
          MenuItem(title: 'Remove Bank'),
          MenuItem(title: 'Set as active'),
        ],
        onClickMenu: (value) {},
        stateChanged: (value) {},
        onDismiss: () {});
    return menu;
  }
}

class AddedBankWidget extends StatefulWidget {
  const AddedBankWidget({
    Key key,
  }) : super(key: key);


  @override
  _AddedBankWidgetState createState() => _AddedBankWidgetState();
}

class _AddedBankWidgetState extends State<AddedBankWidget> {
  GlobalKey btnKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    PopupMenu menu = setUpPopUp(context);
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 145,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.kPrimaryColor,
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Spacer(
                flex: 3,
              ),
              Text(
                "Active",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Caros-Bold"),
              ),
              Spacer(
                flex: 2,
              ),
              IconButton(
                key:btnKey,
                icon: Icon(
                  Icons.more_vert,
                  color: AppColors.kWhite,
                ),
                onPressed: () {
                  menu.show(widgetKey: btnKey);
                },
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "01223456",
              style: TextStyle(
                  color: AppColors.kWhite,
                  fontSize: 16,
                  fontFamily: "Caros-Bold"),
            ),
          ),
          YMargin(20),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  "Zenith Bank",
                  style: TextStyle(color: Colors.white),
                ),
                Spacer(),
                Text(
                  "Active",
                  style:
                      TextStyle(color: AppColors.kLightText3),
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Olarenwaju peter Balogun",
              style: TextStyle(color: AppColors.kLightText3),
            ),
          ),
          YMargin(15),
        ],
      ),
    );
  }

  PopupMenu setUpPopUp(BuildContext context) {
    PopupMenu.context = context;
    PopupMenu menu = PopupMenu(
        backgroundColor: AppColors.kPrimaryColor,
        lineColor: AppColors.kLightTitleText,
        items: [
          MenuItem(title: 'Remove Bank'),
          MenuItem(title: 'Set as active'),
        ],
        onClickMenu: (value) {},
        stateChanged: (value) {},
        onDismiss: () {});
    return menu;
  }
}

class PaymentCard extends StatefulWidget {
  const PaymentCard({
    Key key,
  }) : super(key: key);


  @override
  _PaymentCardState createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {
  GlobalKey btnKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    PopupMenu menu = setUpPopUp(context);
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 175,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5)),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              "images/cardBg.png",
              height: 175,
              width: MediaQuery.of(context).size.width - 40,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YMargin(5),
              Row(
                children: [
                  Spacer(
                    flex: 3,
                  ),
                  Text(
                    "Active",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Caros-Bold"),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  IconButton(
                    key: btnKey,
                    icon: Icon(
                      Icons.more_vert,
                      color: AppColors.kWhite,
                    ),
                    onPressed: () {
                      menu.show(widgetKey: btnKey);
                    },
                  )
                ],
              ),
              YMargin(25),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "**** **** *** 01223456",
                  style: TextStyle(
                      color: AppColors.kWhite,
                      fontSize: 20,
                      fontFamily: "Caros-Bold"),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Card Holder",
                          style: TextStyle(color: Colors.white, fontSize: 8),
                        ),
                        Text(
                          "Diana Meyer",
                          style: TextStyle(color: Colors.white,
                              fontFamily: "Caros-Bold", fontSize: 14),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Expiry",
                          style: TextStyle(color: Colors.white, fontSize: 8),
                        ),
                        Text(
                          "12/20",
                          style: TextStyle(color: Colors.white,
                              fontFamily: "Caros-Bold", fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              YMargin(15),
            ],
          ),
        ],
      ),
    );
  }
  PopupMenu setUpPopUp(BuildContext context) {
    PopupMenu.context = context;
    PopupMenu menu = PopupMenu(
        backgroundColor: AppColors.kPrimaryColor,
        lineColor: AppColors.kLightTitleText,
        items: [
          MenuItem(title: 'Remove Bank'),
          MenuItem(title: 'Set as active'),
        ],
        onClickMenu: (value) {},
        stateChanged: (value) {},
        onDismiss: () {});
    return menu;
  }
}
