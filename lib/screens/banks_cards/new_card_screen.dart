import 'package:flutter/material.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/widgets/account_widgets.dart';
import 'package:zimvest/widgets/appbars.dart';
import 'package:zimvest/widgets/buttons.dart';

class NewCardScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => NewCardScreen(),
        settings: RouteSettings(name: NewCardScreen().toStringShort()));
  }
  @override
  _NewCardScreenState createState() => _NewCardScreenState();
}

class _NewCardScreenState extends State<NewCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ZimAppBar(title: "Add a new card",),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          YMargin(20),
          TextWidgetBorder(title: "Card Number",textColor: AppColors.kAccountTextColor,),
          TextWidgetBorder(title: "Expiry date",textColor: AppColors.kAccountTextColor,),
          TextWidgetBorder(title: "cvv",textColor: AppColors.kAccountTextColor,keyboardType: TextInputType.number,),
          YMargin(20),
          PrimaryButton(
            title: "Add Card",
            onPressed: (){},
          )
        ],),
      ),
    );
  }
}
