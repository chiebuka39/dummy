import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:zimvest/styles/colors.dart';

class DonutPieChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DonutPieChart(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory DonutPieChart.withSampleData() {
    return new DonutPieChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList,
        animate: animate,


        // Configure the width of the pie slices to 60px. The remaining space in
        // the chart will be left as a hole in the center.
        defaultRenderer: new charts.ArcRendererConfig(

            strokeWidthPx: 0,
            arcWidth: 40,
            arcRendererDecorators: [new charts.ArcLabelDecorator()]));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 100,charts.ColorUtil.fromDartColor(AppColors.kPrimaryColor),),
      new LinearSales(75, 75,charts.ColorUtil.fromDartColor(Color(0xFF324d53))),
      new LinearSales(2, 25,charts.ColorUtil.fromDartColor(AppColors.kLightText)),
    ];

    return [
      new charts.Series<LinearSales, int>(
          id: 'Sales',
          domainFn: (LinearSales sales, _) => sales.year,
          measureFn: (LinearSales sales, _) => sales.sales,
          data: data,
          colorFn: (LinearSales series, _) => series.barColor,
          insideLabelStyleAccessorFn: (LinearSales row, i) {
            if(i == 2){
              return charts.TextStyleSpec(fontSize: 14, color: charts.Color.black);;
            }else{
              return charts.TextStyleSpec(fontSize: 14, color: charts.Color.white);
            }

          },

          labelAccessorFn: (LinearSales row, _) => '${row.year}%')
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;
  final charts.Color barColor;

  LinearSales(this.year, this.sales, this.barColor);
}