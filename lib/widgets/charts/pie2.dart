import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';


class PieChartSample2 extends StatefulWidget {
  final bool dollar;

  PieChartSample2({Key key, this.dollar = false}) : super(key: key);
  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartSample2> {
  int touchedIndex;



  @override
  Widget build(BuildContext context) {

    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${widget.dollar == true ? 'Dollar':'Naira'} Portfolio", style: TextStyle(fontFamily: AppStrings.fontMedium),),
            YMargin((12)),
            Row(children: [
              Transform.translate(
                  offset:Offset(0,-4),
                  child: Text(widget.dollar ?'\$' :'AppStrings.nairaSymbol', style: TextStyle(fontSize: 14,color: AppColors.kGreyText),)),
              XMargin(2),
              Text("000,000",
                style: TextStyle(fontSize: 25,
                    color: AppColors.kGreyText,
                    fontFamily: AppStrings.fontMedium),),
              XMargin(3),
              Transform.translate(
                offset:Offset(0,-4),
                child: Text(".00",
                  style: TextStyle(fontSize: 14, fontFamily: AppStrings.fontMedium, color: AppColors.kGreyText,)),
              ),
            ],),
            YMargin(16),
            Transform.translate(
              offset: Offset(-7,0),
              child: Row(children: [
                Icon(Icons.arrow_drop_up_outlined),
                Text("${widget.dollar ?'\$' :AppStrings.nairaSymbol}0",
                  style: TextStyle(fontFamily: AppStrings.fontMedium),),
                XMargin(5),
                Text("(0.00%)",
                  style: TextStyle(fontFamily: AppStrings.fontMedium),),
                XMargin(5),
                Text("Past 24h",
                  style: TextStyle(),),
              ],),
            )
          ],
        ),

        Transform.scale(
          scale: .6,
          child: Container(
            width: 170,
            height: 170,
            child: PieChart(
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
          ),
        ),

      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: 15,
            title: '15%',
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