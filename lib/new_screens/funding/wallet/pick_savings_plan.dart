import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:zimvest/data/models/saving_plan.dart';
import 'package:zimvest/data/view_models/savings_view_model.dart';
import 'package:zimvest/data/view_models/wallets_view_model.dart';
import 'package:zimvest/new_screens/funding/top_up_screen.dart';
import 'package:zimvest/new_screens/funding/wallet/top_up_plan_screen.dart';
import 'package:zimvest/new_screens/navigation/portfolio/aspire_widgets.dart';
import 'package:zimvest/new_screens/navigation/wealth/wealth_box_details.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';

class PickSavingsPlanSceen extends StatefulWidget {
  final List<SavingPlanModel> aspirePlans;

  const PickSavingsPlanSceen({Key key, this.aspirePlans}) : super(key: key);

  static Route<dynamic> route({List<SavingPlanModel> aspirePlans}) {
    return MaterialPageRoute(
        builder: (_) => PickSavingsPlanSceen(
              aspirePlans: aspirePlans,
            ),
        settings: RouteSettings(name: PickSavingsPlanSceen().toStringShort()));
  }

  @override
  _PickSavingsPlanSceenState createState() => _PickSavingsPlanSceenState();
}

class _PickSavingsPlanSceenState extends State<PickSavingsPlanSceen> {
  List<SavingPlanModel> aspirePlans;

  @override
  void initState() {
    // aspirePlans = widget.aspirePlans;
    super.initState();
  }

  ABSSavingViewModel savingViewModel;
  @override
  Widget build(BuildContext context) {
    savingViewModel = Provider.of(context);
    List<SavingPlanModel> goals = savingViewModel.savingPlanModel
        .where((element) => element.productId == 2)
        .toList();
    SavingPlanModel wealthBox = savingViewModel.savingPlanModel
        .where((element) => element.productId == 1)
        .first;
    return ViewModelProvider<WalletViewModel>.withConsumer(
      viewModelBuilder: () => WalletViewModel(),
      onModelReady: (model) => model.getWallets(),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.navigate_before_rounded,
              color: AppColors.kPrimaryColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pick a Savings Plan",
                style: TextStyle(fontSize: 15, fontFamily: AppStrings.fontBold),
              ),
              YMargin(33),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, TopUpPlanScreen.route(wallets: model.wallets, savingsPlan: savingViewModel.savingPlanModel));
                },
                child: Container(
                  height: 154,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                    color: AppColors.kWhite,
                    boxShadow: AppUtils.getBoxShaddow,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      YMargin(3),
                      Text(wealthBox.planName),
                      Spacer(),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Balance",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: AppStrings.fontNormal,
                                    color: AppColors.kGreyText),
                              ),
                              YMargin(10),
                              Text(
                                "${AppStrings.nairaSymbol}${wealthBox.amountSaved}",
                                style: TextStyle(
                                    color: AppColors.kGreyText,
                                    fontFamily: AppStrings.fontMedium),
                              )
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Interest P.A",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: AppStrings.fontNormal,
                                    color: AppColors.kGreyText),
                              ),
                              YMargin(10),
                              Text(
                                "${wealthBox.interestRate}%",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: AppColors.kGreyText,
                                    fontFamily: AppStrings.fontMedium),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Text(
                      "Goals",
                      style: TextStyle(
                          fontFamily: AppStrings.fontMedium,
                          color: AppColors.kGreyText),
                    ),
                    XMargin(3),
                    Text(
                      "(Zimvest aspire)",
                      style: TextStyle(
                          fontFamily: AppStrings.fontNormal,
                          color: AppColors.kGreyText,
                          fontSize: 12),
                    ),
                  ],
                ),
              ),
              goals == null
                  ? Center(
                      child: Text("No Plans to display."),
                    )
                  : Expanded(
                      child: GridView.builder(
                        itemCount: goals.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AspireContainerWidget(
                            goal: goals[index],
                          ),
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.7, crossAxisCount: 2),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
