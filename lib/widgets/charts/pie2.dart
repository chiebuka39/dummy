import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';


class PieChartSample2 extends StatefulWidget {
  final bool dollar;
  final String value;
  final double investmentValue;
  final double savingsValue;
  final double walletValue;

  PieChartSample2({Key key, this.dollar = false, this.value,
    this.investmentValue = 15,
    this.savingsValue = 35,
    this.walletValue = 50}) : super(key: key);
  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartSample2> {
  int touchedIndex;



  @override
  Widget build(BuildContext context) {
    print("ppppnmn ${widget.value}");

    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${widget.dollar == true ? 'Dollar':'Naira'} Portfolio", style: TextStyle(fontFamily: AppStrings.fontNormal,
                color: AppColors.kSecondaryText, fontSize: 12),),
            YMargin((12)),
            Row(children: [
              Transform.translate(
                  offset:Offset(0,-4),
                  child: Text(widget.dollar ?'\$' :'${AppStrings.nairaSymbol}', style: TextStyle(fontSize: 14,color: AppColors.kSecondaryBoldText),)),
              XMargin(2),
              Text(widget.value.split(".").first.substring(1),
                style: TextStyle(fontSize: 25,
                    color: AppColors.kSecondaryBoldText,
                    fontFamily: AppStrings.fontMedium),),
              XMargin(3),
              Transform.translate(
                offset:Offset(0,-4),
                child: Text(".${widget.value.split(".").last}",
                    style: TextStyle(fontSize: 14, fontFamily: AppStrings.fontMedium, color: AppColors.kSecondaryBoldText,)),
              ),
            ],),
            YMargin(16),
            Transform.translate(
              offset: Offset(-7,0),
              child: Row(children: [
                Icon(Icons.arrow_drop_up_outlined, color: AppColors.kFixed,),
                Text("${widget.dollar ?'\$' :AppStrings.nairaSymbol}0",
                  style: TextStyle(fontFamily: AppStrings.fontMedium,color: AppColors.kFixed, fontSize: 11),),
                XMargin(5),
                Text("(0.00%)",
                  style: TextStyle(fontFamily: AppStrings.fontMedium,color: AppColors.kFixed, fontSize: 11),),
                XMargin(5),
                Text("Past 24h",
                  style: TextStyle(color: AppColors.kSecondaryText, fontSize: 11),),
              ],),
            )
          ],
        ),
        Spacer(),
        Transform.translate(
          offset: Offset(20,0),
          child: Transform.scale(
            scale: .6,
            child: Container(
              width: 170,
              height: 170,
              child: Stack(
                children: [
                  PieChart(
                    PieChartData(

                        pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                          setState(() {
                            if (pieTouchResponse.touchInput is FlLongPressEnd ||
                                pieTouchResponse.touchInput is FlPanEnd) {
                              touchedIndex = -1;
                            } else {
                              touchedIndex = pieTouchResponse.touchedSectionIndex;
                            }
                          });
                        }),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 60,
                        sections: showingSections()),
                  ),
                  Positioned(
                    left: 40,
                    right: 0,
                    top: 75,
                    bottom: 0,
                    child: Text("Breakdown", style: TextStyle(fontFamily: AppStrings.fontMedium, fontSize: 17),),
                  )
                ],
              ),
            ),
          ),
        ),

      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: AppColors.kSavingsP,
            value: widget.savingsValue,
            title: '${widget.savingsValue}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: AppColors.kInvestmentP,
            value: widget.investmentValue,
            title: '${widget.investmentValue}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: AppColors.kYellow,
            value: widget.walletValue,
            title: '${widget.walletValue}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );

        default:
          return null;
      }
    });
  }
}