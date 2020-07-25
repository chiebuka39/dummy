import 'package:flutter/material.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/widgets/account_widgets.dart';
import 'package:zimvest/widgets/appbars.dart';
import 'package:zimvest/widgets/buttons.dart';

class NewBankScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => NewBankScreen(),
        settings: RouteSettings(name: NewBankScreen().toStringShort()));
  }
  @override
  _NewBankScreenState createState() => _NewBankScreenState();
}

class _NewBankScreenState extends State<NewBankScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ZimAppBar(title: "Add new bank",),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          YMargin(20),
          TextWidgetBorder(title: "Bank Name",textColor: AppColors.kAccountTextColor,),
          TextWidgetBorder(title: "Account Number",textColor: AppColors.kAccountTextColor,
            keyboardType: TextInputType.number,),
          YMargin(20),
          PrimaryButton(
            title: "Validate Bank",
            onPressed: (){},
          )
        ],),
      ),
    );
  }
}
