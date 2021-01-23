import 'package:after_layout/after_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/models/product_transaction.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/savings_view_model.dart';
import 'package:zimvest/new_screens/navigation/wealth/aspire_box_details.dart';
import 'package:zimvest/new_screens/navigation/wealth/investment_details.dart';
import 'package:zimvest/new_screens/navigation/widgets/money_title_widget.dart';
import 'package:zimvest/new_screens/navigation/wealth/wealth_box_details.dart';
import 'package:zimvest/new_screens/navigation/widgets/transaction_item_widget.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/home/action_box_widgets.dart';
import 'package:zimvest/widgets/navigation/wealthbox_detail_widget.dart';
import 'package:zimvest/widgets/new/loading.dart';

import 'widgets/earn_free_cash.dart';

class TransactionsScreen extends StatefulWidget {
  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  bool showInvest = false;

  @override
  Widget build(BuildContext context) {
    double tabWidth = MediaQuery.of(context).size.width - 40;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
                  YMargin(15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      "Transactions",
                      style: TextStyle(
                          fontSize: 16, fontFamily: AppStrings.fontBold),
                    ),
                    Spacer(),
                    EarnFreeCashWidget()
                  ],
                ),
              ),
              YMargin(33),
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
                                  setState(() {
                                    showInvest = false;
                                  });
                                },
                                child: Container(
                                    child: Center(
                                        child: Text(
                                  "Savings",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: showInvest == false
                                          ? Colors.white
                                          : AppColors.kPrimaryColor),
                                ))),
                              )),
                              Expanded(
                                  child: InkWell(
                                onTap: () {
                                  setState(() {
                                    showInvest = true;
                                  });
                                },
                                child: Container(
                                    child: Center(
                                        child: Text(
                                  "Investment",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: showInvest == true
                                          ? Colors.white
                                          : AppColors.kPrimaryColor),
                                ))),
                              )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                ],
              ),
              YMargin(30),
            ])),
            showInvest
                ? PortfolioInvestmentWidget()
                : SavingTransactionsWidget(),
          ],
        ),
      ),
    );
  }
}

class SavingTransactionsEmptyWidget extends StatelessWidget {
  const SavingTransactionsEmptyWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      sliver: SliverList(
          delegate: SliverChildListDelegate([
        YMargin(MediaQuery.of(context).size.height > 700 ? 350 : 250),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 200,
                child: Text(
                  "You currently don’t have a savings transaction",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: AppStrings.fontNormal,
                      color: AppColors.kGreyText,
                      height: 1.6),
                )),
          ],
        ),
        YMargin(40),
      ])),
      padding: EdgeInsets.symmetric(horizontal: 20),
    );
  }
}

class SavingTransactionsWidget extends StatefulWidget {
  const SavingTransactionsWidget({
    Key key,
  }) : super(key: key);

  @override
  _SavingTransactionsWidgetState createState() =>
      _SavingTransactionsWidgetState();
}

class _SavingTransactionsWidgetState extends State<SavingTransactionsWidget>
    with AfterLayoutMixin<SavingTransactionsWidget> {
  bool topUp = true;

  ABSSavingViewModel savingViewModel;
  ABSIdentityViewModel identityViewModel;

  @override
  void afterFirstLayout(BuildContext context) async {
    savingViewModel.getSavingsTopup(
      token: identityViewModel.user.token,
    );
    savingViewModel.getSavingsWithdrawal(
      token: identityViewModel.user.token,
    );
  }

  @override
  Widget build(BuildContext context) {
    savingViewModel = Provider.of(context);
    identityViewModel = Provider.of(context);
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          YMargin(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 30,
                child: Stack(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                topUp = true;
                              });
                            },
                            child: Text(
                              "Top ups",
                              style: TextStyle(
                                  color: topUp
                                      ? AppColors.kPrimaryColor
                                      : AppColors.kTextColor.withOpacity(0.5),
                                  fontSize: 12,
                                  fontFamily: topUp
                                      ? AppStrings.fontMedium
                                      : AppStrings.fontNormal),
                            )),
                        Spacer(),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                topUp = false;
                              });
                            },
                            child: Text("Withdrawal",
                                style: TextStyle(
                                    color: topUp
                                        ? AppColors.kTextColor.withOpacity(0.5)
                                        : AppColors.kPrimaryColor,
                                    fontSize: 12,
                                    fontFamily: topUp
                                        ? AppStrings.fontNormal
                                        : AppStrings.fontMedium))),
                      ],
                    ),
                    AnimatedPositioned(
                        top: 20,
                        left: topUp ? 5 : 90,
                        child: Container(
                          height: 3,
                          width: 40,
                          decoration:
                              BoxDecoration(color: AppColors.kPrimaryColor),
                        ),
                        duration: Duration(milliseconds: 300))
                  ],
                ),
              )
            ],
          ),
          topUp
              ? savingViewModel.savingsTransactions[1] == null
                  ? ShimmerLoading()
                  : savingViewModel.savingsTransactions[1].isEmpty
                      ? EmptyInvstmentWidget()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...List.generate(
                                savingViewModel.savingsTransactions[1].length,
                                (index) {
                              ProductTransaction trans =
                                  savingViewModel.savingsTransactions[1][index];
                              return TransactionItemWidget(
                                narration: trans.transactionDescription,
                                date: AppUtils.getReadableDateShort(
                                    trans.dateUpdated),
                                amount: trans.amount,
                                symbol: AppStrings.nairaSymbol,
                                trans: trans,
                              );
                            }),
                            YMargin(50)
                          ],
                        )
              : savingViewModel.savingsTransactions[2] == null
                  ? ShimmerLoading()
                  : savingViewModel.savingsTransactions[2].isEmpty
                      ? EmptyInvstmentWidget()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...List.generate(
                                savingViewModel.savingsTransactions[2].length,
                                (index) {
                              ProductTransaction trans =
                                  savingViewModel.savingsTransactions[2][index];
                              return TransactionItemWidget(
                                trans: trans,
                                narration: trans.transactionDescription,
                                date: AppUtils.getReadableDateShort(
                                    trans.dateUpdated),
                                amount: trans.amount,
                                symbol: AppStrings.nairaSymbol,
                                topUp: false,
                              );
                            }),
                            YMargin(50)
                          ],
                        ),
        ]),
      ),
    );
  }
}

class PortfolioInvestmentWidget extends StatefulWidget {
  const PortfolioInvestmentWidget({
    Key key,
  }) : super(key: key);

  @override
  _PortfolioInvestmentWidgetState createState() =>
      _PortfolioInvestmentWidgetState();
}

class _PortfolioInvestmentWidgetState extends State<PortfolioInvestmentWidget> {
  bool topUp = true;
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          YMargin(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 30,
                child: Stack(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                topUp = true;
                              });
                            },
                            child: Text(
                              "Top Ups",
                              style: TextStyle(
                                  color: topUp
                                      ? AppColors.kPrimaryColor
                                      : AppColors.kTextColor,
                                  fontSize: 12,
                                  fontFamily: topUp
                                      ? AppStrings.fontMedium
                                      : AppStrings.fontNormal),
                            )),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              topUp = false;
                            });
                          },
                          child: Text(
                            "Withdrawals",
                            style: TextStyle(
                                color: topUp
                                    ? AppColors.kTextColor
                                    : AppColors.kPrimaryColor,
                                fontSize: 12,
                                fontFamily: topUp
                                    ? AppStrings.fontNormal
                                    : AppStrings.fontMedium),
                          ),
                        ),
                      ],
                    ),
                    AnimatedPositioned(
                        top: 20,
                        left: topUp ? 5 : 90,
                        child: Container(
                          height: 3,
                          width: 35,
                          decoration:
                              BoxDecoration(color: AppColors.kPrimaryColor),
                        ),
                        duration: Duration(milliseconds: 300))
                  ],
                ),
              )
            ],
          ),
          topUp
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: Text("Coming Soon"),
                  ),
                )
              // ? EmptyInvstmentWidget(investment: true,)
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: Text("Coming Soon"),
                  ),
                )
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     ...List.generate(6, (index) => TransactionItemWidget()),
          //     YMargin(50)
          //   ],
          // ),
        ]),
      ),
    );
  }
}

class EmptyInvstmentWidget extends StatelessWidget {
  const EmptyInvstmentWidget({
    Key key,
    this.investment = false,
  }) : super(key: key);

  final bool investment;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        YMargin(MediaQuery.of(context).size.height > 700 ? 300 : 200),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 200,
                child: Text(
                  "You do not have any ${investment ? 'investment' : 'Savings'} transaction",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: AppStrings.fontNormal,
                      color: AppColors.kGreyText,
                      height: 1.6),
                )),
          ],
        ),
        YMargin(40),
      ],
    );
  }
}
