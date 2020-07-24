import 'package:flutter/material.dart';
import 'package:zimvest/animations/pop_up_menu.dart';
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

class _ManageCardsAndBankState extends State<ManageCardsAndBank> with SingleTickerProviderStateMixin {
  GlobalKey btnKey = GlobalKey();
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this,length: 2);
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
          child: Icon(Icons.add, color: Colors.white,),
          onPressed: (){
            print("cff");
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
        child: Column(children: [
          YMargin(20),
          Text("Manage your cards and banks: cards are "
              "used for funding while banks are "
              "used for withdrawals.",
            style: TextStyle(fontSize: 12, color: AppColors.kAccountTextColor),),
          TabBar(
            controller: _tabController,
            labelColor: AppColors.kPrimaryColor2,
            unselectedLabelColor: AppColors.kLightTitleText,
            labelStyle: TextStyle(fontFamily: "Caros-Medium", fontSize: 12),
            unselectedLabelStyle: TextStyle(fontFamily: "Caros", fontSize: 12),
            indicatorColor: AppColors.kAccentColor,
            indicatorWeight: 3,
            tabs: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text("Cards",),
              ),
              Text("Banks")
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView(children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 145,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.kPrimaryColor,
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Row(children: [
                        Spacer(flex: 3,),
                        Text("Active", style: TextStyle(color: Colors.white,fontFamily: "Caros-Bold"),),
                        Spacer(flex: 2,),
                        IconButton(
                          key:btnKey,
                          icon: Icon(Icons.more_vert, color: AppColors.kWhite,),onPressed: (){
                            menu.show(widgetKey: btnKey);
                        },)
                      ],),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text("01223456",
                            style: TextStyle(
                                color: AppColors.kWhite,
                              fontSize: 16,
                              fontFamily: "Caros-Bold"
                            ),),
                        ),
                        YMargin(20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(children: [
                            Text("Zenith Bank", style: TextStyle(color: Colors.white),),
                            Spacer(),
                            Text("Active",style: TextStyle(color: AppColors.kLightText3),),
                          ],),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text("Olarenwaju peter Balogun",
                            style: TextStyle(color: AppColors.kLightText3),),
                        ),
                        YMargin(15),

                    ],),
                  )
                ],),
                Icon(Icons.directions_transit),

              ],
            ),
          )
        ],),
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
    
        onClickMenu: (value){},
        stateChanged: (value){},
        onDismiss: (){});
    return menu;
  }
}
