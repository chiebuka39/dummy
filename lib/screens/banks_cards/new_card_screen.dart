import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zimvest/payment/input_formaters.dart';
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
        child: SingleChildScrollView(
          child: Column(children: [
            YMargin(20),
            CardWidgetBorder(title: "Card Number",
              textColor: AppColors.kAccountTextColor,inputFormaters: [
                WhitelistingTextInputFormatter.digitsOnly,
                new LengthLimitingTextInputFormatter(19),
                new CardNumberInputFormatter()
              ],keyboardType: TextInputType.number,),
            CardWidgetBorder(title: "Expiry date",
              textColor: AppColors.kAccountTextColor,
              inputFormaters: [
                WhitelistingTextInputFormatter.digitsOnly,
                new LengthLimitingTextInputFormatter(4),
                new CardMonthInputFormatter()
              ],
              keyboardType: TextInputType.number,
            ),
            CardWidgetBorder(title: "cvv",
              textColor: AppColors.kAccountTextColor,
              keyboardType: TextInputType.number,inputFormaters: [
                WhitelistingTextInputFormatter.digitsOnly,
                new LengthLimitingTextInputFormatter(4),
              ],),
            YMargin(20),
            PrimaryButton(
              title: "Add Card",
              onPressed: (){},
            )
          ],),
        ),
      ),
    );
  }
}
