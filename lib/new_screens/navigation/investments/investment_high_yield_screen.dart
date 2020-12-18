import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
import 'package:zimvest/new_screens/navigation/investments/high_yield/dollar/invetment_high_yield_dollar_screen.dart';
import 'package:zimvest/new_screens/navigation/investments/high_yield/naira/investment_high_yield_naira.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';

class InvestmentHighYieldScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (_) => InvestmentHighYieldScreen(),
      settings: RouteSettings(
        name: InvestmentHighYieldScreen().toStringShort(),
      ),
    );
  }

  @override
  _InvestmentHighYieldScreenState createState() =>
      _InvestmentHighYieldScreenState();
}

class _InvestmentHighYieldScreenState extends State<InvestmentHighYieldScreen> {
  bool showInvest = false;
  @override
  Widget build(BuildContext context) {
    double tabWidth = MediaQuery.of(context).size.width - 40;
    return ViewModelProvider<InvestmentHighYieldViewModel>.withConsumer(
      viewModelBuilder: () => InvestmentHighYieldViewModel(),
      onModelReady: (model) => model.getNairaTermInstruments(),
      builder: (context, model, _) => Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YMargin(55),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: ImageIcon(
                  AssetImage("images/cancel.png"),
                  color: AppColors.kAccentColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            YMargin(26),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Zimvest High Yield",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: AppStrings.fontBold,
                    color: AppColors.kTextColor),
              ),
            ),
            YMargin(30),
            Row(
              children: <Widget>[
                Spacer(),
                Container(
                  width: tabWidth,
                  height: 40,
                  decoration: BoxDecoration(
                      color: AppColors.kPrimaryColorLight,
                      borderRadius: BorderRadius.circular(13)),
                  child: Stack(
                    children: <Widget>[
                      AnimatedPositioned(
                        left: showInvest == true ? tabWidth / 2 : 0,
                        duration: Duration(milliseconds: 300),
                        child: Container(
                          width: tabWidth / 2,
                          height: 40,
                          decoration: BoxDecoration(
                              color: AppColors.kPrimaryColor,
                              borderRadius: BorderRadius.circular(13)),
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  model.getNairaTermInstruments();
                                  setState(() {
                                    showInvest = false;
                                  });
                                },
                                child: Container(
                                  child: Center(
                                    child: Text(
                                      "High Yield Naira",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: showInvest == false
                                              ? Colors.white
                                              : AppColors.kPrimaryColor),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  model.getDollarTermInstruments();
                                  setState(() {
                                    showInvest = true;
                                  });
                                },
                                child: Container(
                                  child: Center(
                                    child: Text(
                                      "High Yield Dollar",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: showInvest == true
                                              ? Colors.white
                                              : AppColors.kPrimaryColor),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
            // TODO: Fix Red Screen
            YMargin(30),
            showInvest
                ? Container(
                    child: model.busy == true 
                        ? Center(
                          child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation(AppColors.kPrimaryColor),
                            ),
                        )
                        : HighYieldDollarScreen(instrument: model.dollarInstrument.data,),
                  )
                : Container(
                    child: model.busy == true 
                        ? Center(
                          child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation(AppColors.kPrimaryColor),
                            ),
                        )
                        : HighYieldNairaScreen(instrument: model.nairaInstrument.data,),
                  )
          ],
        ),
      ),
    );
  }
}
