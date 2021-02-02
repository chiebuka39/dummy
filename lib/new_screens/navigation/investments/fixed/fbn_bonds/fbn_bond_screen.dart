import 'package:flutter/material.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:zimvest/animations/loading.dart';
import 'package:zimvest/data/models/investment/fixed_models.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
import 'package:zimvest/new_screens/navigation/investments/fixed/fbn_bonds/all_fbn_bond_investments.dart';
import 'package:zimvest/new_screens/navigation/investments/fixed/fbn_bonds/fixed_income_details.dart';
import 'package:zimvest/new_screens/navigation/investments/widgets/card_widget.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margins.dart';
import 'package:zimvest/utils/strings.dart';

class FBNBondPagePage extends StatefulWidget {
  @override
  _FBNBondPagePageState createState() => _FBNBondPagePageState();
}

class _FBNBondPagePageState extends State<FBNBondPagePage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<InvestmentHighYieldViewModel>.withConsumer(
      onModelReady: (model) => model.getFGNBond(),
      builder: (context, model, _) => Container(
        child: Center(
          child: model.fgnBond.data == null
              ? LoadingWIdget()
              : model.fgnBond.data.fgnBondItems[1].bonds.length == 0
                  ? Text("Not Available")
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        List<FgnBondItems> timePeriod =
                            model.fgnBond.data.fgnBondItems;
                        List<FGNBonds> toShow = model.fgnBond.data.fgnBondItems
                            .where((element) =>
                                element.tenorBandName ==
                                timePeriod[index].tenorBandName)
                            .toList()[0]
                            .bonds;
                        return toShow.length == 0
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0, bottom: 8.0),
                                child: Container(
                                  height: screenHeight(context) / 3.0,
                                  width: screenWidth(context),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${timePeriod[index].tenorBandName}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontFamily:
                                                    AppStrings.fontNormal,
                                                color: AppColors.kTextColor,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () => {
                                                Navigator.push(
                                                  context,
                                                  AllFBNBonds.route(
                                                      bondItem: model.fgnBond
                                                          .data.fgnBondItems,
                                                      title: timePeriod[index]
                                                          .tenorBandName),
                                                )
                                              },
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "See all",
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      fontFamily:
                                                          AppStrings.fontNormal,
                                                      color: AppColors
                                                          .kPrimaryColor,
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.chevron_right,
                                                    size: 11,
                                                    color:
                                                        AppColors.kPrimaryColor,
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
                                                scrollDirection:
                                                    Axis.horizontal,
                                                children: model
                                                    .fgnBond.data.fgnBondItems
                                                    .where((element) =>
                                                        element.tenorBandName ==
                                                        timePeriod[index]
                                                            .tenorBandName)
                                                    .toList()[0]
                                                    .bonds
                                                    .map(
                                                      (e) => GestureDetector(
                                                        onTap: () =>
                                                            Navigator.push(
                                                          context,
                                                          FixedIncomeDetails
                                                              .route(
                                                            bondName:
                                                                e.bondName,
                                                            id: e.id,
                                                            maturityDate: e
                                                                .investmentMaturityDate,
                                                            rate: e.rate,
                                                            investmentType: e
                                                                .investmentType,
                                                            instrumentId:
                                                                e.instrumentId,
                                                            minimumAmount:
                                                                e.minimumAmount,
                                                            investmentMaturityDate:
                                                                e.investmentMaturityDate,
                                                          ),
                                                        ),
                                                        child: FixedIncomeCard(
                                                          bondName: e.bondName,
                                                          maturityDate:
                                                              e.maturityDate,
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
                      itemCount: model.fgnBond.data.fgnBondItems.length,
                    ),
        ),
      ),
      viewModelBuilder: () => InvestmentHighYieldViewModel(),
    );
  }
}
