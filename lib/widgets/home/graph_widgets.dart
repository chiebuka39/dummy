import 'package:flutter/material.dart';
import 'package:zimvest/data/view_models/dashboard_view_model.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/widgets/bar_charts.dart';
import 'package:zimvest/widgets/home/assets_distribution.dart';

class GraphsWidget extends StatefulWidget {
  const GraphsWidget({
    Key key,
    @required this.dashboardViewModel,
  }) : super(key: key);

  final ABSDashboardViewModel dashboardViewModel;

  @override
  _GraphsWidgetState createState() => _GraphsWidgetState();
}

class _GraphsWidgetState extends State<GraphsWidget> {
  PageController pageController;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Container(

      child: Scaffold(
        body: PageView(
          controller: pageController,
          children: [
            SingleChildScrollView(
              child: Column(children: [
                YMargin(20),
                Row(
                  children: [

                    IconButton(icon: Icon(Icons.close),
                        onPressed: (){
                          Navigator.of(context).pop();
                        }),

                    Spacer(),
                    Text("Portfolio Distribution", style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Caros-Bold",
                        color: AppColors.kPrimaryColor2
                    ),),
                    Spacer(),
                    IconButton(icon: Icon(Icons.navigate_next),
                        onPressed: (){
                          pageController.animateToPage(1,
                              duration:Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        }),
                  ],
                ),
                buildDonut(widget.dashboardViewModel),


                ...widget.dashboardViewModel.portfolioDistribution.asMap().map((index, value) {
                  return MapEntry(index, Container(
                    height: 67,
                    width: double.infinity,
                    color: index.isEven ? Color(0xFFF4F4F4): Colors.white,
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          decoration: BoxDecoration(
                              color: AppColors.donutColor[index]
                          ),
                        ),
                        XMargin(26),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(value.portfolioName, style: TextStyle(
                                      fontFamily: "Caros-Bold", fontSize: 12),),
                                  Spacer(),
                                  Text("${value.percentageShare}%", style: TextStyle(color: AppColors.kPrimaryColor2,fontSize: 12, fontFamily: "Caros-Bold"),),
                                  XMargin(30)
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 7),
                                child: Text("\u20A6 3,000,000", style: TextStyle(fontSize: 12),),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ));
                }).values.toList()

              ],),
            ),
            SingleChildScrollView(
              child: Column(children: [
                YMargin(20),
                Row(
                  children: [
                    IconButton(icon: Icon(Icons.navigate_before),
                        onPressed: (){
                          pageController.animateToPage(0,
                              duration:Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        }),
                    Spacer(),
                    Text("Asset Distribution", style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Caros-Bold",
                        color: AppColors.kPrimaryColor2
                    ),),
                    Spacer(),
                    IconButton(icon: Icon(Icons.close_rounded),
                        onPressed: (){
                          Navigator.of(context).pop();
                        }),
                  ],
                ),
                //buildDonut(widget.dashboardViewModel),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: 200,
                    width: double.infinity,
                    child: SimpleBarChart.withSampleData(widget.dashboardViewModel.assetDistribution)),
                XMargin(30),

                ...widget.dashboardViewModel.assetDistribution.model.asMap().map((index, value) {
                  return MapEntry(index, Container(
                    height: 67,
                    width: double.infinity,
                    color: index.isEven ? Color(0xFFF4F4F4): Colors.white,
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          decoration: BoxDecoration(
                              color: AppColors.donutColor[index]
                          ),
                        ),
                        XMargin(26),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(value.instrumentName, style: TextStyle(
                                      fontFamily: "Caros-Bold", fontSize: 12),),
                                  Spacer(),
                                  Text("${value.percentageValue}%", style: TextStyle(color: AppColors.kPrimaryColor2,fontSize: 12, fontFamily: "Caros-Bold"),),
                                  XMargin(30)
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 7),
                                child: Text("\u20A6 3,000,000", style: TextStyle(fontSize: 12),),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ));
                }).values.toList()

              ],),
            ),
          ],
        ),
      ),
    );
  }
}