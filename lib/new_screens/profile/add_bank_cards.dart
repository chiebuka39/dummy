import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zimvest/new_screens/withdrawals/add_bank_account.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';

class AddBankAndCards extends StatefulWidget {

  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => AddBankAndCards(),
        settings:
        RouteSettings(name: AddBankAndCards().toStringShort()));
  }

  @override
  _AddBankAndCardsState createState() => _AddBankAndCardsState();
}

class _AddBankAndCardsState extends State<AddBankAndCards> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.kPrimaryColor),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined,size: 20,),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.transparent,
          title: Text("Banks & Cards",
            style: TextStyle(color: Colors.black87,
                fontSize: 13,
                fontFamily: AppStrings.fontMedium),),
          bottom: TabBar(
            indicatorColor: AppColors.kPrimaryColor,
            labelColor: AppColors.kPrimaryColor,
              unselectedLabelColor: AppColors.kGreyText,
              tabs: const <Widget>[
                Tab( text: "Banks",),
                Tab(text: "Cards",),
              ]),
        ),
        body: TabBarView(
          children: [
            BankWidget(),
            CardWidget(),
          ],
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Spacer(flex: 2,),
        SvgPicture.asset("images/new/Addd1.svg"),
        YMargin(20),
        Text("Add your Debit Card", style: TextStyle(fontSize: 13,
            fontFamily: AppStrings.fontMedium,
            color: AppColors.kPrimaryColor),),

        Spacer(flex: 3,),
      ],),
    );
  }
}

class BankWidget extends StatelessWidget {
  const BankWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Spacer(flex: 2,),
        GestureDetector(
          onTap: (){
            Navigator.push(context, AddBankAccScreen.route());
          },
            child: SvgPicture.asset("images/new/Addd1.svg")),
        YMargin(20),
        Text("Add your Bank Account", style: TextStyle(fontSize: 13,
            fontFamily: AppStrings.fontMedium,
            color: AppColors.kPrimaryColor),),

        Spacer(flex: 3,),
      ],),
    );
  }
}
