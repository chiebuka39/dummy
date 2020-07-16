import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:zimvest/styles/colors.dart';

class SimpleBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleBarChart(this.seriesList, {this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory SimpleBarChart.withSampleData() {
    return new SimpleBarChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      new OrdinalSales(year:'2014', sales:5, barColor: charts.ColorUtil.fromDartColor(AppColors.kPrimaryColor),),
      new OrdinalSales(year:'2015', sales:25, barColor: charts.ColorUtil.fromDartColor(AppColors.kPrimaryColor),),
      new OrdinalSales(year:'2016', sales:100, barColor: charts.ColorUtil.fromDartColor(AppColors.kPrimaryColor),),
      new OrdinalSales(year:'2017', sales:75, barColor: charts.ColorUtil.fromDartColor(AppColors.kPrimaryColor),),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (series, _) => series.barColor,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;
  final charts.Color barColor;

  OrdinalSales({this.year, this.sales, this.barColor});
}