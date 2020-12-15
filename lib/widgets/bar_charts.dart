import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:zimvest/data/models/dashboard.dart';
import 'package:zimvest/styles/colors.dart';

class SimpleBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleBarChart(this.seriesList, {this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory SimpleBarChart.withSampleData(AssetDistribution assetDistribution) {
    return new SimpleBarChart(
      _createSampleData(assetDistribution),
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
  static List<charts.Series<OrdinalSales, String>> _createSampleData(AssetDistribution assetDistribution) {
    List<OrdinalSales> sales = [];
    assetDistribution.model.asMap().forEach((index,element) {
      sales.add(OrdinalSales(year:index.toString(),
        sales:element.percentageValue.toInt(), barColor: charts.ColorUtil.fromDartColor(AppColors.donutColor[index]),),);
    });


    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (series, _) => series.barColor,
        keyFn: (sales,index) => index.toString(),
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: sales,
          labelAccessorFn: (OrdinalSales row, _) => '')
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