import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:zimvest/data/view_models/base_model.dart';
import 'package:zimvest/new_screens/navigation/wealth/liquidat_asset/initial_review.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

class WithdrawWealthScreen extends StatefulWidget {
  final String name;
  final double withDrawable;
  final int transactionId;
  final int instrumentId;
  const WithdrawWealthScreen({
    Key key,
    this.name,
    this.withDrawable,
    this.transactionId,
    this.instrumentId,
  }) : super(key: key);
  static Route<dynamic> route(
      {String name, double withDrawable, int transactionId, int instrumentId}) {
    return MaterialPageRoute(
        builder: (_) => WithdrawWealthScreen(
              name: name,
              withDrawable: withDrawable,
              transactionId: transactionId,
              instrumentId: instrumentId,
            ),
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
                  Navigator.push(
                    context,
                    InitialReviewScreen.route(
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
                      name: widget.name,
                      withDrawable: widget.withDrawable,
                      transactionId: widget.transactionId,
                      instrumentId: widget.instrumentId,
                      isBank: false
                    ),
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
