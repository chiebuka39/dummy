import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:timelines/timelines.dart';
import 'package:zimvest/new_screens/portfolio_breakdown/dollar_portfolio_breakdown.dart';
import 'package:zimvest/new_screens/portfolio_breakdown/naira_portfolio_breakdown.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/home/action_box_widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController controller = PageController();


  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                        height: 34,
                        width: 34,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: AppColors.kGrey),
                        child:
                            Center(child: SvgPicture.asset("images/profile.svg"))),
                    XMargin(20),
                    Text("Hi, Emmanuel"),
                    Spacer(),
                    Container(
                      width: 115,
                      height: 28,
                      decoration: BoxDecoration(
                        color: AppColors.kGrey,
                        borderRadius: BorderRadius.circular(14)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        SvgPicture.asset("images/gift.svg"),
                        XMargin(6),
                        Text("Earn Free Cash",
                          style: TextStyle(fontSize: 10,fontFamily: AppStrings.fontNormal),)
                      ],),
                    )
                  ],
                ),
              ),
              Container(
                height: 165,
                child: PageView(
                  controller: controller,
                  children: [
                    Container(
                      height: 165,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 30,horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Naira Portfolio",
                            style: TextStyle(
                                fontFamily: AppStrings.fontMedium),),
                          YMargin(12),
                          Row(children: [
                            Transform.translate(
                                offset:Offset(0,-4),
                                child: Text(AppStrings.nairaSymbol, style: TextStyle(fontSize: 14),)),
                            XMargin(2),
                            Text("000,000",
                              style: TextStyle(fontSize: 25, fontFamily: AppStrings.fontMedium),),
                            XMargin(3),
                            Transform.translate(
                              offset:Offset(0,-4),
                              child: Text(".00",
                                style: TextStyle(fontSize: 14, fontFamily: AppStrings.fontMedium),),
                            ),
                          ],),
                          YMargin(16),
                          Row(children: [
                            Icon(Icons.arrow_drop_up_outlined),
                            Text("${AppStrings.nairaSymbol}0",
                              style: TextStyle(fontFamily: AppStrings.fontMedium),),
                            XMargin(5),
                            Text("(0.00%)",
                              style: TextStyle(fontFamily: AppStrings.fontMedium),),
                            XMargin(5),
                            Text("Past 24h",
                              style: TextStyle(),),
                            Spacer(),
                            Transform.translate(
                              offset: Offset(0,2),
                              child: GestureDetector(
                                onTap:(){
                                  Navigator.of(context).push(NairaPortfolioBreakdownScreen.route());
                                },
                                child: Row(children: [
                                  Text("Portfolio Breakdown", style: TextStyle(color: AppColors.kGreyText,
                                      fontSize: 11,fontFamily: AppStrings.fontNormal),),
                                  Icon(Icons.navigate_next_rounded, color: AppColors.kGreyText,size: 19,)
                                ],),
                              ),
                            )

                          ],)
                        ],),),
                    Container(
                      height: 165,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 30,horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Dollar Portfolio",
                            style: TextStyle(
                                fontFamily: AppStrings.fontMedium),),
                          YMargin(12),
                          Row(children: [
                            Transform.translate(
                                offset:Offset(0,-4),
                                child: Text(AppStrings.nairaSymbol, style: TextStyle(fontSize: 14),)),
                            XMargin(2),
                            Text("000,000",
                              style: TextStyle(fontSize: 25, fontFamily: AppStrings.fontMedium),),
                            XMargin(3),
                            Transform.translate(
                              offset:Offset(0,-4),
                              child: Text(".00",
                                style: TextStyle(fontSize: 14, fontFamily: AppStrings.fontMedium),),
                            ),
                          ],),
                          YMargin(16),
                          Row(children: [
                            Icon(Icons.arrow_drop_up_outlined),
                            Text("${AppStrings.nairaSymbol}0",
                              style: TextStyle(fontFamily: AppStrings.fontMedium),),
                            XMargin(5),
                            Text("(0.00%)",
                              style: TextStyle(fontFamily: AppStrings.fontMedium),),
                            XMargin(5),
                            Text("Past 24h",
                              style: TextStyle(),),
                            Spacer(),
                            Transform.translate(
                              offset: Offset(0,2),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.of(context).push(DollarPortfolioBreakdownScreen.route());
                                },
                                child: Row(children: [
                                  Text("Portfolio Breakdown", style: TextStyle(color: AppColors.kGreyText,
                                      fontSize: 11,fontFamily: AppStrings.fontNormal),),
                                  Icon(Icons.navigate_next_rounded, color: AppColors.kGreyText,size: 19,)
                                ],),
                              ),
                            )

                          ],)
                        ],),),
                  ],
                ),
              ),

              SmoothPageIndicator(
                  controller: controller,  // PageController
                  count: 2,
                  effect:  WormEffect(
                      dotWidth: 8,
                      dotHeight: 8,
                      activeDotColor: AppColors.kGreyText
                  ),  // your preferred effect
                  onDotClicked: (index){

                  }
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text("Actions"),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 120,
                  child: Timeline1(actions: ['Verify Identity','Fund Wallet'],)),
              ActionBoxWidget(title: "Save with Zimvest wealth box", desc: "This savings plan assists you save in a "
                  "disciplined manner."),
              ActionBoxWidget(title: "Save with Zimvest Aspire", desc: "This savings plan assists you save in a "
                  "disciplined manner."),
              ActionBoxWidget(title: "Invest in Zimvest High Yield", desc: "This savings plan assists you save in a "
                  "disciplined manner."),

              ActionBoxWidget(title: "Invest in Zimvest Fixed Income",desc: "This savings plan assists you save in a "
                  "disciplined manner.",),
            ],
          ),
        ),
      ),
    );
  }
}



class Timeline1 extends StatelessWidget {
  final List<String> actions;

  const Timeline1({Key key, this.actions}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Timeline.tileBuilder(
      theme: TimelineThemeData(
        nodePosition: 0,
        connectorTheme: ConnectorThemeData(
          thickness: 3.0,
          color: Color(0xffd3d3d3),
        ),
        indicatorTheme: IndicatorThemeData(
          size: 15.0,
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 20.0),
      builder: TimelineTileBuilder.connected(
        contentsBuilder: (_, index) => _EmptyContents(title: actions[index],),
        connectorBuilder: (_, index, __) {
          if (index == 0) {
            return SolidLineConnector(color: Color(0xffE9E9E9),thickness: 1,);
          } else {
            return SolidLineConnector();
          }
        },
        indicatorBuilder: (_, index) {
          return Container(
            width: 22,
            height: 22,
            child: Center(child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                border: Border.all(color: Color(0xFF979797))
              ),
            ),),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffE9E9E9)
            ),
          );
        },
        itemExtentBuilder: (_, __) => kTileHeight,
        itemCount: actions.length,
      ),
    );
  }
}

const kTileHeight = 50.0;
class _EmptyContents extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _EmptyContents({Key key, this.title, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.0),
      height: 30.0,
      child: Row(children: [
        Text(title, style: TextStyle(fontSize: 12, fontFamily: AppStrings.fontNormal),),
        Spacer(),
        Icon(Icons.arrow_forward_ios_rounded,size: 16,)
      ],),
    );
  }
}

