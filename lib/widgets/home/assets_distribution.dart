import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/dashboard_view_model.dart';
import 'package:zimvest/widgets/bar_charts.dart';
import 'package:zimvest/widgets/donut_chart.dart';

class StatsWidget extends StatelessWidget {
  const StatsWidget({
    Key key,
    @required this.thirdController,
  }) : super(key: key);

  final PageController thirdController;

  @override
  Widget build(BuildContext context) {
    ABSDashboardViewModel dashboardViewModel = Provider.of(context);
    //print("llll ${dashboardViewModel.assetDistribution.model.length}");
    return Container(
      height: 200,
      width: double.infinity,
      child: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: thirdController,
        children: [
          buildDonut(dashboardViewModel),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  thirdController.animateToPage(0,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn);
                },
              ),
              Spacer(),
              Container(
                  height: 200,
                  width: 250,
                  child: SimpleBarChart.withSampleData()),
              Spacer(),
              Opacity(
                opacity: 0,
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    print("ooo");
                    thirdController.animateToPage(1,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn);
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }


}
Row buildDonut(ABSDashboardViewModel dashboardViewModel) {
  return Row(
    children: [
      Spacer(),
      Container(
          height: 250,
          width: 250,
          child: dashboardViewModel.portfolioDistribution.where(
                  (element) => element.percentageShare > 0).length > 0 ?
          DonutPieChart.withSampleData(dashboardViewModel.portfolioDistribution):Container(
            child: Center(child: Image.asset("images/no_portfolio.png", height: 150,),),
          )),
      Spacer(),

    ],
  );
}