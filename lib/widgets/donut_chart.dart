import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:zimvest/data/models/dashboard.dart';
import 'package:zimvest/styles/colors.dart';

class DonutPieChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DonutPieChart(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory DonutPieChart.withSampleData(List<PortfolioDistribution> distr) {
    return new DonutPieChart(
      _createSampleData(distr),
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
            arcWidth: 50,
            arcRendererDecorators: [new charts.ArcLabelDecorator()]));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData(List<PortfolioDistribution> distr) {
    final data = List.generate(distr.length, (index) => LinearSales(
        distr[index].percentageShare.toInt(), distr[index].percentageShare.toInt(),
        charts.ColorUtil.fromDartColor(AppColors.donutColor[index])));



    return [
      new charts.Series<LinearSales, int>(
          id: 'Sales',
          domainFn: (LinearSales sales, _) => sales.year,
          measureFn: (LinearSales sales, _) => sales.sales,
          data: data,
          colorFn: (LinearSales series, _) => series.barColor,


          labelAccessorFn: (LinearSales row, _) => '')
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