import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';

class MoneyTitleWidget extends StatelessWidget {
  const MoneyTitleWidget({
    Key key,
    this.amount,
  }) : super(key: key);

  final double amount;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.translate(
            offset: Offset(0, -4),
            child: Text(
              AppStrings.nairaSymbol,
              style: TextStyle(fontSize: 14),
            )),
        XMargin(2),
        Text(
          FlutterMoneyFormatter(amount: amount).output.withoutFractionDigits,
          style: TextStyle(fontSize: 25, fontFamily: AppStrings.fontMedium),
        ),
        XMargin(3),
        Transform.translate(
          offset: Offset(0, -4),
          child: Text(
            ".00",
            style: TextStyle(fontSize: 14, fontFamily: AppStrings.fontMedium),
          ),
        ),
      ],
    );
  }
}