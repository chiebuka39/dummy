import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:zimvest/data/models/investment/fixed_models.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
import 'package:zimvest/new_screens/navigation/investments/fixed/treasury_bills/all_tbills_investments.dart';
import 'package:zimvest/new_screens/navigation/investments/fixed/treasury_bills/fixed_income_details.dart';
import 'package:zimvest/new_screens/navigation/investments/widgets/card_widget.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margins.dart';
import 'package:zimvest/utils/strings.dart';

class TreasuryBillPage extends StatefulWidget {
  @override
  _TreasuryBillPageState createState() => _TreasuryBillPageState();
}

class _TreasuryBillPageState extends State<TreasuryBillPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<InvestmentHighYieldViewModel>.withConsumer(
      onModelReady: (model) => model.getTreasuryBill(),
      builder: (context, model, _) => Container(
        child: Center(
          child: model.treasuryBills.data == null
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(AppColors.kPrimaryColor),
                )
              : model.treasuryBills.data.tBillsItems[1].treasureBills.length ==
                      0
                  ? Text("Nothing to Show")
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        List<TBillsItems> timePeriod =
                            model.treasuryBills.data.tBillsItems;
                        List<TreasureBills> toShow = model
                            .treasuryBills.data.tBillsItems
                            .where((element) =>
                                element.tenorBandName ==
                                timePeriod[index].tenorBandName)
                            .toList()[0]
                            .treasureBills;
                        return toShow.length == 0 ? Container(): Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Container(
                            height: screenHeight(context) / 3.0,
                            width: screenWidth(context),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child:  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${timePeriod[index].tenorBandName}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: AppStrings.fontNormal,
                                          color: AppColors.kTextColor,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () => Navigator.push(
                                          context,
                                          AllTreasurryBillBonds.route(
                                              title: timePeriod[index]
                                                  .tenorBandName,
                                              bondItem: model.treasuryBills.data
                                                  .tBillsItems),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              "See all",
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontFamily:
                                                    AppStrings.fontNormal,
                                                color: AppColors.kPrimaryColor,
                                              ),
                                            ),
                                            Icon(
                                              Icons.chevron_right,
                                              size: 11,
                                              color: AppColors.kPrimaryColor,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: screenHeight(context) / 4.5,
                                  width: screenWidth(context),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: model
                                              .treasuryBills.data.tBillsItems
                                              .where((element) =>
                                                  element.tenorBandName ==
                                                  timePeriod[index]
                                                      .tenorBandName)
                                              .toList()[0]
                                              .treasureBills
                                              .map(
                                                (e) => GestureDetector(
                                                  onTap: () => Navigator.push(
                                                    context,
                                                    FixedIncomeDetails.route(
                                                      bondName:
                                                          e.treasuryBillName,
                                                      id: e.id,
                                                      maturityDate: e
                                                          .investmentMaturityDate,
                                                      rate: e.rate,
                                                      investmentType:
                                                          e.investmentType,
                                                      instrumentId:
                                                          e.instrumentId,
                                                      minimumAmount:
                                                          e.minimumAmount,
                                                      investmentMaturityDate: e
                                                          .investmentMaturityDate,
                                                    ),
                                                  ),
                                                  child: FixedIncomeCard(
                                                    bondName:
                                                        e.treasuryBillName,
                                                    maturityDate: e
                                                        .investmentMaturityDate,
                                                    minimumAmount:
                                                        e.minimumAmount,
                                                    rate: e.rate,
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: model.treasuryBills.data.tBillsItems.length,
                    ),
        ),
      ),
      viewModelBuilder: () => InvestmentHighYieldViewModel(),
    );
  }
}
