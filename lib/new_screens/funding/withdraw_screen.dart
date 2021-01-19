import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:zimvest/data/view_models/base_model.dart';
import 'package:zimvest/new_screens/funding/select_bank_account.dart';
import 'package:zimvest/new_screens/withdrawals/choose_wealth_withdraw_source.dart';

import 'package:zimvest/payment/input_formaters.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

class WithdrawWealthScreen extends StatefulWidget {
  const WithdrawWealthScreen({
    Key key,
  }) : super(key: key);
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => WithdrawWealthScreen(),
        settings: RouteSettings(name: WithdrawWealthScreen().toStringShort()));
  }

  @override
  _WithdrawWealthScreenState createState() => _WithdrawWealthScreenState();
}

class _WithdrawWealthScreenState extends State<WithdrawWealthScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<BaseViewModel>.withConsumer(
      viewModelBuilder: () => BaseViewModel(),
      onModelReady: (model) => model.getUserBank(),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black87),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              size: 20,
              color: AppColors.kPrimaryColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.transparent,
          title: Text(
            "Withdraw",
            style: TextStyle(
                color: AppColors.kTextColor,
                fontSize: 14,
                fontFamily: AppStrings.fontMedium),
          ),
        ),
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
                  Navigator.push(context,
                      SelectBankAccount.route(banks: model.banks.data));
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
              SelectWallet(onPressed: null),
            ],
          ),
        ),
      ),
    );
  }
}
