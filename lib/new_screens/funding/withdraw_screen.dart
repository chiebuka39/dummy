import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:zimvest/data/view_models/base_model.dart';
import 'package:zimvest/new_screens/navigation/investments/widgets/util_widgt.dart';
import 'package:zimvest/new_screens/navigation/wealth/liquidate_asset/fixed_income/commercial_paper/initial_review_cp.dart';
import 'package:zimvest/new_screens/navigation/wealth/liquidate_asset/fixed_income/coporate_bond/initial_review_cb.dart';
import 'package:zimvest/new_screens/navigation/wealth/liquidate_asset/fixed_income/euro_bond/initial_review_eb.dart';
import 'package:zimvest/new_screens/navigation/wealth/liquidate_asset/fixed_income/fgnbond/initial_review_fgb.dart';
import 'package:zimvest/new_screens/navigation/wealth/liquidate_asset/fixed_income/promissorynote/initial_review_pn.dart';
import 'package:zimvest/new_screens/navigation/wealth/liquidate_asset/fixed_income/treasury_bills/initial_review_tbills.dart';
import 'package:zimvest/new_screens/navigation/wealth/liquidate_asset/initial_review.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

class WithdrawWealthScreen extends StatefulWidget {
  final String name;
  final double withDrawable;
  final int transactionId;
  final int instrumentId;
  final int fixedInvestmentType;
  const WithdrawWealthScreen({
    Key key,
    this.name,
    this.withDrawable,
    this.transactionId,
    this.instrumentId,
    this.fixedInvestmentType,
  }) : super(key: key);
  static Route<dynamic> route(
      {String name,
      double withDrawable,
      int transactionId,
      int instrumentId,
      int fixedInvestmentType}) {
    return MaterialPageRoute(
        builder: (_) => WithdrawWealthScreen(
              name: name,
              withDrawable: withDrawable,
              transactionId: transactionId,
              instrumentId: instrumentId,
              fixedInvestmentType: fixedInvestmentType,
            ),
        settings: RouteSettings(name: WithdrawWealthScreen().toStringShort()));
  }

  @override
  _WithdrawWealthScreenState createState() => _WithdrawWealthScreenState();
}

class _WithdrawWealthScreenState extends State<WithdrawWealthScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.fixedInvestmentType);
    if (widget.fixedInvestmentType == 0) {
      return ViewModelProvider<BaseViewModel>.withConsumer(
        viewModelBuilder: () => BaseViewModel(),
        onModelReady: (model) => model.getUserBank(),
        builder: (context, model, _) => Scaffold(
          appBar: appBar(context),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YMargin(69),
                Text(
                  "Choose Withdrawal Destination?",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.kTextColor,
                      fontSize: 15,
                      fontFamily: AppStrings.fontNormal),
                ),
                YMargin(52),
                GestureDetector(
                  onTap: () {
                    print("moving");
                    Navigator.push(
                      context,
                      InitialReviewScreen.route(
                        fixedInvestmentType: widget.fixedInvestmentType,
                        name: widget.name,
                        withDrawable: widget.withDrawable,
                        transactionId: widget.transactionId,
                        instrumentId: widget.instrumentId,
                        isBank: true,
                        banks: model.banks.data,
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                        color: AppColors.kPrimaryColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        SvgPicture.asset("images/new/bank.svg"),
                        XMargin(10),
                        Text(
                          "Bank Account",
                          style: TextStyle(
                              color: AppColors.kWhite,
                              fontSize: 13,
                              fontFamily: AppStrings.fontNormal),
                        ),
                        Spacer(),
                        Icon(
                          Icons.navigate_next_rounded,
                          color: AppColors.kWhite,
                        )
                      ],
                    ),
                  ),
                ),
                YMargin(25),
                SelectWallet(
                  onPressed: () {
                    Navigator.push(
                      context,
                      InitialReviewScreen.route(
                          fixedInvestmentType: widget.fixedInvestmentType,
                          name: widget.name,
                          withDrawable: widget.withDrawable,
                          transactionId: widget.transactionId,
                          instrumentId: widget.instrumentId,
                          isBank: false),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    } else if (widget.fixedInvestmentType == 1) {
      return ViewModelProvider<BaseViewModel>.withConsumer(
        viewModelBuilder: () => BaseViewModel(),
        onModelReady: (model) => model.getUserBank(),
        builder: (context, model, _) => Scaffold(
          appBar: appBar(context),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YMargin(69),
                Text(
                  "Choose Withdrawal Destination?",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.kTextColor,
                      fontSize: 15,
                      fontFamily: AppStrings.fontNormal),
                ),
                YMargin(52),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      InitialReviewScreenTreasuryBills.route(
                        fixedInvestmentType: widget.fixedInvestmentType,
                        name: widget.name,
                        withDrawable: widget.withDrawable,
                        transactionId: widget.transactionId,
                        instrumentId: widget.instrumentId,
                        isBank: true,
                        banks: model.banks.data,
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                        color: AppColors.kPrimaryColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        SvgPicture.asset("images/new/bank.svg"),
                        XMargin(10),
                        Text(
                          "Bank Account",
                          style: TextStyle(
                              color: AppColors.kWhite,
                              fontSize: 13,
                              fontFamily: AppStrings.fontNormal),
                        ),
                        Spacer(),
                        Icon(
                          Icons.navigate_next_rounded,
                          color: AppColors.kWhite,
                        )
                      ],
                    ),
                  ),
                ),
                YMargin(25),
                SelectWallet(
                  onPressed: () {
                    Navigator.push(
                      context,
                      InitialReviewScreenTreasuryBills.route(
                          fixedInvestmentType: widget.fixedInvestmentType,
                          name: widget.name,
                          withDrawable: widget.withDrawable,
                          transactionId: widget.transactionId,
                          instrumentId: widget.instrumentId,
                          isBank: false),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    } else if (widget.fixedInvestmentType == 2) {
      return ViewModelProvider<BaseViewModel>.withConsumer(
        viewModelBuilder: () => BaseViewModel(),
        onModelReady: (model) => model.getUserBank(),
        builder: (context, model, _) => Scaffold(
          appBar: appBar(context),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YMargin(69),
                Text(
                  "Choose Withdrawal Destination?",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.kTextColor,
                      fontSize: 15,
                      fontFamily: AppStrings.fontNormal),
                ),
                YMargin(52),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      InitialReviewScreenCommercialPaper.route(
                        fixedInvestmentType: widget.fixedInvestmentType,
                        name: widget.name,
                        withDrawable: widget.withDrawable,
                        transactionId: widget.transactionId,
                        instrumentId: widget.instrumentId,
                        isBank: true,
                        banks: model.banks.data,
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                        color: AppColors.kPrimaryColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        SvgPicture.asset("images/new/bank.svg"),
                        XMargin(10),
                        Text(
                          "Bank Account",
                          style: TextStyle(
                              color: AppColors.kWhite,
                              fontSize: 13,
                              fontFamily: AppStrings.fontNormal),
                        ),
                        Spacer(),
                        Icon(
                          Icons.navigate_next_rounded,
                          color: AppColors.kWhite,
                        )
                      ],
                    ),
                  ),
                ),
                YMargin(25),
                SelectWallet(
                  onPressed: () {
                    Navigator.push(
                      context,
                      InitialReviewScreenCommercialPaper.route(
                          fixedInvestmentType: widget.fixedInvestmentType,
                          name: widget.name,
                          withDrawable: widget.withDrawable,
                          transactionId: widget.transactionId,
                          instrumentId: widget.instrumentId,
                          isBank: false),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    } else if (widget.fixedInvestmentType == 3) {
      return ViewModelProvider<BaseViewModel>.withConsumer(
        viewModelBuilder: () => BaseViewModel(),
        onModelReady: (model) => model.getUserBank(),
        builder: (context, model, _) => Scaffold(
          appBar: appBar(context),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YMargin(69),
                Text(
                  "Choose Withdrawal Destination?",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.kTextColor,
                      fontSize: 15,
                      fontFamily: AppStrings.fontNormal),
                ),
                YMargin(52),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      InitialReviewScreenEuroBond.route(
                        fixedInvestmentType: widget.fixedInvestmentType,
                        name: widget.name,
                        withDrawable: widget.withDrawable,
                        transactionId: widget.transactionId,
                        instrumentId: widget.instrumentId,
                        isBank: true,
                        banks: model.banks.data,
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                        color: AppColors.kPrimaryColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        SvgPicture.asset("images/new/bank.svg"),
                        XMargin(10),
                        Text(
                          "Bank Account",
                          style: TextStyle(
                              color: AppColors.kWhite,
                              fontSize: 13,
                              fontFamily: AppStrings.fontNormal),
                        ),
                        Spacer(),
                        Icon(
                          Icons.navigate_next_rounded,
                          color: AppColors.kWhite,
                        )
                      ],
                    ),
                  ),
                ),
                YMargin(25),
                SelectWallet(
                  onPressed: () {
                    Navigator.push(
                      context,
                      InitialReviewScreenEuroBond.route(
                          fixedInvestmentType: widget.fixedInvestmentType,
                          name: widget.name,
                          withDrawable: widget.withDrawable,
                          transactionId: widget.transactionId,
                          instrumentId: widget.instrumentId,
                          isBank: false),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    } else if (widget.fixedInvestmentType == 4) {
      return ViewModelProvider<BaseViewModel>.withConsumer(
        viewModelBuilder: () => BaseViewModel(),
        onModelReady: (model) => model.getUserBank(),
        builder: (context, model, _) => Scaffold(
          appBar: appBar(context),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YMargin(69),
                Text(
                  "Choose Withdrawal Destination?",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.kTextColor,
                      fontSize: 15,
                      fontFamily: AppStrings.fontNormal),
                ),
                YMargin(52),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      InitialReviewScreenFGNBond.route(
                        fixedInvestmentType: widget.fixedInvestmentType,
                        name: widget.name,
                        withDrawable: widget.withDrawable,
                        transactionId: widget.transactionId,
                        instrumentId: widget.instrumentId,
                        isBank: true,
                        banks: model.banks.data,
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                        color: AppColors.kPrimaryColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        SvgPicture.asset("images/new/bank.svg"),
                        XMargin(10),
                        Text(
                          "Bank Account",
                          style: TextStyle(
                              color: AppColors.kWhite,
                              fontSize: 13,
                              fontFamily: AppStrings.fontNormal),
                        ),
                        Spacer(),
                        Icon(
                          Icons.navigate_next_rounded,
                          color: AppColors.kWhite,
                        )
                      ],
                    ),
                  ),
                ),
                YMargin(25),
                SelectWallet(
                  onPressed: () {
                    Navigator.push(
                      context,
                      InitialReviewScreenFGNBond.route(
                          fixedInvestmentType: widget.fixedInvestmentType,
                          name: widget.name,
                          withDrawable: widget.withDrawable,
                          transactionId: widget.transactionId,
                          instrumentId: widget.instrumentId,
                          isBank: false),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    } else if (widget.fixedInvestmentType == 5) {
      return ViewModelProvider<BaseViewModel>.withConsumer(
        viewModelBuilder: () => BaseViewModel(),
        onModelReady: (model) => model.getUserBank(),
        builder: (context, model, _) => Scaffold(
          appBar: appBar(context),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YMargin(69),
                Text(
                  "Choose Withdrawal Destination?",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.kTextColor,
                      fontSize: 15,
                      fontFamily: AppStrings.fontNormal),
                ),
                YMargin(52),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      InitialReviewScreenPromissoryNote.route(
                        fixedInvestmentType: widget.fixedInvestmentType,
                        name: widget.name,
                        withDrawable: widget.withDrawable,
                        transactionId: widget.transactionId,
                        instrumentId: widget.instrumentId,
                        isBank: true,
                        banks: model.banks.data,
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                        color: AppColors.kPrimaryColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        SvgPicture.asset("images/new/bank.svg"),
                        XMargin(10),
                        Text(
                          "Bank Account",
                          style: TextStyle(
                              color: AppColors.kWhite,
                              fontSize: 13,
                              fontFamily: AppStrings.fontNormal),
                        ),
                        Spacer(),
                        Icon(
                          Icons.navigate_next_rounded,
                          color: AppColors.kWhite,
                        )
                      ],
                    ),
                  ),
                ),
                YMargin(25),
                SelectWallet(
                  onPressed: () {
                    Navigator.push(
                      context,
                      InitialReviewScreenPromissoryNote.route(
                          fixedInvestmentType: widget.fixedInvestmentType,
                          name: widget.name,
                          withDrawable: widget.withDrawable,
                          transactionId: widget.transactionId,
                          instrumentId: widget.instrumentId,
                          isBank: false),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    } else if (widget.fixedInvestmentType == 6) {
      return ViewModelProvider<BaseViewModel>.withConsumer(
        viewModelBuilder: () => BaseViewModel(),
        onModelReady: (model) => model.getUserBank(),
        builder: (context, model, _) => Scaffold(
          appBar: appBar(context),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YMargin(69),
                Text(
                  "Choose Withdrawal Destination?",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.kTextColor,
                      fontSize: 15,
                      fontFamily: AppStrings.fontNormal),
                ),
                YMargin(52),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      InitialReviewScreenCorporateBond.route(
                        fixedInvestmentType: widget.fixedInvestmentType,
                        name: widget.name,
                        withDrawable: widget.withDrawable,
                        transactionId: widget.transactionId,
                        instrumentId: widget.instrumentId,
                        isBank: true,
                        banks: model.banks.data,
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                        color: AppColors.kPrimaryColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        SvgPicture.asset("images/new/bank.svg"),
                        XMargin(10),
                        Text(
                          "Bank Account",
                          style: TextStyle(
                              color: AppColors.kWhite,
                              fontSize: 13,
                              fontFamily: AppStrings.fontNormal),
                        ),
                        Spacer(),
                        Icon(
                          Icons.navigate_next_rounded,
                          color: AppColors.kWhite,
                        )
                      ],
                    ),
                  ),
                ),
                YMargin(25),
                SelectWallet(
                  onPressed: () {
                    Navigator.push(
                      context,
                      InitialReviewScreenCorporateBond.route(
                          fixedInvestmentType: widget.fixedInvestmentType,
                          name: widget.name,
                          withDrawable: widget.withDrawable,
                          transactionId: widget.transactionId,
                          instrumentId: widget.instrumentId,
                          isBank: false),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
