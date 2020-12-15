import 'package:flutter/material.dart';
import 'package:zimvest/new_screens/navigation/portfolio_screen.dart';
import 'package:zimvest/styles/colors.dart';

class PickInvestmentPlan extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => PickInvestmentPlan(),
        settings: RouteSettings(name: PickInvestmentPlan().toStringShort()));
  }
  @override
  _PickInvestmentPlanState createState() => _PickInvestmentPlanState();
}

class _PickInvestmentPlanState extends State<PickInvestmentPlan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.navigate_before_rounded, color: AppColors.kPrimaryColor,),onPressed: (){
          Navigator.pop(context);
        },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(itemBuilder: (context, index){
          return InvestmentItemWidget();
        },itemCount: 5,),
      ),
    );
  }
}
