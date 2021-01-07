import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:zimvest/data/models/saving_plan.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/savings_view_model.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/widgets/plans/aspire_container.dart';
import 'package:zimvest/widgets/plans/wealth_box.dart';

class PortfolioBreakdownScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => PortfolioBreakdownScreen(),
        settings:
            RouteSettings(name: PortfolioBreakdownScreen().toStringShort()));
  }

  @override
  _PortfolioBreakdownScreenState createState() =>
      _PortfolioBreakdownScreenState();
}

class _PortfolioBreakdownScreenState extends State<PortfolioBreakdownScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBg,
      body: SafeArea(
        child: Column(
          children: [
            YMargin(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "My total portfolio balance",
                        style: TextStyle(
                            fontSize: 12, color: AppColors.kAccountTextColor),
                      ),
                      YMargin(5),
                      Text(
                        "NGN 5,000,000",
                        style: TextStyle(
                            fontSize: 25,
                            fontFamily: "Caros-Bold",
                            color: AppColors.kAccountTextColor),
                      )
                    ],
                  ),
                  Spacer(),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.close))
                ],
              ),
            ),
            YMargin(40),
            WealthBoxBreakDownWidget(),
            YMargin(20),
            AspireBreakDownWidget()
          ],
        ),
      ),
    );
  }
}

class WealthBoxBreakDownWidget extends StatefulWidget {
  const WealthBoxBreakDownWidget({
    Key key,
  }) : super(key: key);

  @override
  _WealthBoxBreakDownWidgetState createState() =>
      _WealthBoxBreakDownWidgetState();
}

class _WealthBoxBreakDownWidgetState extends State<WealthBoxBreakDownWidget>
    with AfterLayoutMixin<WealthBoxBreakDownWidget> {
  ABSSavingViewModel savingViewModel;
  ABSIdentityViewModel identityViewModel;
  bool _loading = true;

  @override
  void afterFirstLayout(BuildContext context) async {
    await Future.delayed(2.seconds());
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  "Zimvest wealth box",
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Caros-Medium",
                      color: AppColors.kAccountTextColor),
                ),
              ],
            ),
          ),
          _loading ? WealthBoxContainer() : _buildLoading(context)
        ],
      ),
    );
  }

  Padding _buildLoading(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SkeletonLoader(
        builder: Container(
          height: 140,
          margin: EdgeInsets.only(top: 20),
          width: MediaQuery.of(context).size.width - 40,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(20)),
        ),
        items: 1,
        period: Duration(seconds: 2),
        //highlightColor: AppColors.kPrimaryColor2.withOpacity(0.1),
        direction: SkeletonDirection.ltr,
      ),
    );
  }
}

class AspireBreakDownWidget extends StatefulWidget {
  const AspireBreakDownWidget({
    Key key,
  }) : super(key: key);

  @override
  _AspireBreakDownWidgetState createState() => _AspireBreakDownWidgetState();
}

class _AspireBreakDownWidgetState extends State<AspireBreakDownWidget>
    with AfterLayoutMixin<AspireBreakDownWidget> {
  ABSSavingViewModel savingViewModel;
  ABSIdentityViewModel identityViewModel;
  bool _loading = true;

  @override
  void afterFirstLayout(BuildContext context) async {
    await Future.delayed(2.seconds());
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  "Zimvest Aspire",
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Caros-Medium",
                      color: AppColors.kAccountTextColor),
                ),
              ],
            ),
          ),
          _loading == false
              ? Container(
                  height: 160,
                  width: double.infinity,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      SavingsAspireContainer2(
                        savingPlanModel: SavingPlanModel(
                            productId: 1,
                            planName: "House rent",
                            targetAmount: 2000000,
                            startDate: DateTime.now(),
                            accruedInterest: 20),
                      ),
                      SavingsAspireContainer2(
                        savingPlanModel: SavingPlanModel(
                            productId: 1,
                            planName: "House rent",
                            targetAmount: 2000000,
                            startDate: DateTime.now(),
                            accruedInterest: 20),
                      ),
                    ],
                  ),
                )
              : _buildLoading(context)
        ],
      ),
    );
  }

  Padding _buildLoading(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SkeletonLoader(
        builder: Container(
          height: 140,
          margin: EdgeInsets.only(top: 20),
          width: MediaQuery.of(context).size.width - 40,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(20)),
        ),
        items: 1,
        period: Duration(seconds: 2),
        //highlightColor: AppColors.kPrimaryColor2.withOpacity(0.1),
        direction: SkeletonDirection.ltr,
      ),
    );
  }
}
