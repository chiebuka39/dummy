import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zimvest/payment/input_formaters.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/widgets/buttons.dart';

class EnterDOBWidget extends StatelessWidget {
  const EnterDOBWidget({
    Key key, this.onNext,
  }) : super(key: key);

  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YMargin(50),
          Text("Enter Your Date of Birth"),
          YMargin(30),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColors.kLightText,
                borderRadius: BorderRadius.circular(12)
            ),
            child: Transform.translate(
              offset: Offset(0,2),
              child: TextField(
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  new LengthLimitingTextInputFormatter(8),
                  new CardMonthInputFormatter()
                ],
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "MM/DD/YYYY",
                    hintStyle: TextStyle(
                        fontSize: 14
                    )
                ),
              ),
            ),
          ),
          Spacer(),
          RoundedNextButton(
            onTap: onNext,
          ),
          YMargin(120)
        ],),
    );
  }
}