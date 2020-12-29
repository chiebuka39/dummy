import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:zimvest/new_screens/navigation/investments/high_yield/dollar/investment_summary_high_yield_dollar.dart';
import 'package:zimvest/new_screens/navigation/investments/high_yield/dollar/payment_source_wired_transfer.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/margins.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

class HighYieldInvestmentDollarPurchaseSource extends StatefulWidget {
  final String uniqueName;
  final int id;
  final String duration;
  final String maturityDate;
  final String rate;
  final String minimumAmount;
  final String maximumAmount;
  final double amount;

  const HighYieldInvestmentDollarPurchaseSource(
      {Key key,
      this.uniqueName,
      this.id,
      this.duration,
      this.maturityDate,
      this.rate,
      this.minimumAmount,
      this.maximumAmount,
      this.amount})
      : super(key: key);
  static Route<dynamic> route(
      {String uniqueName,
      int id,
      String duration,
      String maturityDate,
      String rate,
      String minimumAmount,
      String maximumAmount,
      double amount}) {
    return MaterialPageRoute(
      builder: (_) => HighYieldInvestmentDollarPurchaseSource(
        uniqueName: uniqueName,
        id: id,
        maturityDate: maturityDate,
        rate: rate,
        minimumAmount: minimumAmount,
        maximumAmount: maximumAmount,
        amount: amount,
      ),
      settings: RouteSettings(
        name: HighYieldInvestmentDollarPurchaseSource().toStringShort(),
      ),
    );
  }

  @override
  _HighYieldInvestmentDollarPurchaseSourceState createState() =>
      _HighYieldInvestmentDollarPurchaseSourceState();
}

class _HighYieldInvestmentDollarPurchaseSourceState
    extends State<HighYieldInvestmentDollarPurchaseSource>
    with SingleTickerProviderStateMixin {
  bool isNaira = true;
  TabController controller;

  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Invest",
          style: TextStyle(
            fontSize: 13,
            fontFamily: AppStrings.fontMedium,
            color: AppColors.kTextColor,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.kPrimaryColor,
            ),
            onPressed: () => Navigator.pop(context)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YMargin(69),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 76),
            child: Text(
              "Choose Funding Option",
              style: TextStyle(
                fontSize: 17,
                fontFamily: AppStrings.fontBold,
                color: AppColors.kTextColor,
              ),
            ),
          ),
          verticalSpace(52),
          TabBar(
            controller: controller,
            tabs: [
              Tab(text: "Naira"),
              Tab(text: "Dollar"),
            ],
            unselectedLabelColor: AppColors.kLightText5,
            indicatorColor: AppColors.kPrimaryColor,
            labelColor: AppColors.kPrimaryColor,
          ),
          Expanded(
            child: TabBarView(controller: controller, children: [
              Container(
                child: Column(
                  children: [
                    YMargin(25),
                    // PaymentSourceButton(
                    //   paymentsource: "Naira Wallet",
                    //   image: "wallet",
                    //   amount: "${AppStrings.nairaSymbol}30,000,000",
                    //   color: AppColors.kTextColor,
                    //   onTap: () =>
                    //       Navigator.push(context, InvestmentSummaryScreenDollar.route()),
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: SelectWallet(
                        onPressed: () => Navigator.push(
                          context,
                          InvestmentSummaryScreenDollar.route(
                            channelId: 5,
                            productId: widget.id,
                            duration: widget.duration,
                            amount: widget.amount,
                            uniqueName: widget.uniqueName,
                            maturityDate: widget.maturityDate,
                            rate: widget.rate,
                            minimumAmount: widget.minimumAmount,
                            maximumAmount: widget.maximumAmount,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    YMargin(25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: DollarWallet(
                        onPressed: () => Navigator.push(
                          context,
                          InvestmentSummaryScreenDollar.route(
                            channelId: 5,
                            productId: widget.id,
                            duration: widget.duration,
                            amount: widget.amount,
                            uniqueName: widget.uniqueName,
                            maturityDate: widget.maturityDate,
                            rate: widget.rate,
                            minimumAmount: widget.minimumAmount,
                            maximumAmount: widget.maximumAmount,
                          ),
                        ),
                      ),
                    ),
                    YMargin(25),
                    PaymentSourceButtonSpecial(
                      paymentsource: "Wired Transfer",
                      image: "wallet",
                      onTap: () => Flushbar(
                        margin: EdgeInsets.all(12),
                        borderRadius: 20,
                        flushbarPosition: FlushbarPosition.TOP,
                        titleText: Text(
                          "Coming Soon!",
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: AppStrings.fontBold,
                            color: AppColors.kPrimaryColor,
                          ),
                        ),
                        backgroundColor: AppColors.kPrimaryColorLight,
                        messageText: Text(
                          "This is not currently available",
                          style: TextStyle(
                            fontSize: 11,
                            fontFamily: AppStrings.fontLight,
                            color: AppColors.kPrimaryColor,
                          ),
                        ),
                        duration: Duration(seconds: 3),
                      ).show(context),
                    ),
                    YMargin(25),
                    PaymentSourceButtonSpecial(
                      paymentsource: "R|rexelpay",
                      color: AppColors.kHighYield,
                      onTap: () => Flushbar(
                        // icon: ImageIcon(
                        //   AssetImage("images/failed.png"),
                        //   color: AppColors.kRed,
                        //   size: 70,
                        // ),
                        margin: EdgeInsets.all(12),
                        borderRadius: 20,
                        flushbarPosition: FlushbarPosition.TOP,
                        titleText: Text(
                          "Coming Soon!",
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: AppStrings.fontBold,
                            color: AppColors.kPrimaryColor,
                          ),
                        ),
                        backgroundColor: AppColors.kPrimaryColorLight,
                        messageText: Text(
                          "This is not currently available",
                          style: TextStyle(
                            fontSize: 11,
                            fontFamily: AppStrings.fontLight,
                            color: AppColors.kPrimaryColor,
                          ),
                        ),
                        duration: Duration(seconds: 3),
                      ).show(context),
                    ),
                  ],
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}

// // class NairaPage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       child: Column(
// //         children: [
// //           YMargin(25),
// //           // PaymentSourceButton(
// //           //   paymentsource: "Naira Wallet",
// //           //   image: "wallet",
// //           //   amount: "${AppStrings.nairaSymbol}30,000,000",
// //           //   color: AppColors.kTextColor,
// //           //   onTap: () =>
// //           //       Navigator.push(context, InvestmentSummaryScreenDollar.route()),
// //           // ),
// //           Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 20.0),
// //             child: SelectWallet(
// //               onPressed: () => Navigator.push(
// //                   context, InvestmentSummaryScreenDollar.route(
// //                     channelId: 5,
// //                           productId: widget.productId,
// //                           duration: widget.duration,
// //                           amount: widget.amount,
// //                           uniqueName: widget.uniqueName,
// //                           maturityDate: widget.maturityDate,
// //                           rate: widget.rate,
// //                           minimumAmount: widget.minimumAmount,
// //                           maximumAmount: widget.maximumAmount
// //                   )),
// //             ),
// //           )
// //         ],
// //       ),
// //     );
// //   }
// // }

// class DollarPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: Column(
//       children: [
//         YMargin(25),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//           child: DollarWallet(
//             onPressed: () =>
//                 Navigator.push(context, InvestmentSummaryScreenDollar.route()),
//           ),
//         ),
//         YMargin(25),
//         PaymentSourceButtonSpecial(
//           paymentsource: "Wired Transfer",
//           image: "wallet",
//           onTap: () => Flushbar(
//             margin: EdgeInsets.all(12),
//             borderRadius: 20,
//             flushbarPosition: FlushbarPosition.TOP,
//             titleText: Text(
//               "Coming Soon!",
//               style: TextStyle(
//                 fontSize: 13,
//                 fontFamily: AppStrings.fontBold,
//                 color: AppColors.kPrimaryColor,
//               ),
//             ),
//             backgroundColor: AppColors.kPrimaryColorLight,
//             messageText: Text(
//               "This is not currently available",
//               style: TextStyle(
//                 fontSize: 11,
//                 fontFamily: AppStrings.fontLight,
//                 color: AppColors.kPrimaryColor,
//               ),
//             ),
//             duration: Duration(seconds: 3),
//           ).show(context),
//         ),
//         YMargin(25),
//         PaymentSourceButtonSpecial(
//           paymentsource: "R|rexelpay",
//           color: AppColors.kHighYield,
//           onTap: () => Flushbar(
//             // icon: ImageIcon(
//             //   AssetImage("images/failed.png"),
//             //   color: AppColors.kRed,
//             //   size: 70,
//             // ),
//             margin: EdgeInsets.all(12),
//             borderRadius: 20,
//             flushbarPosition: FlushbarPosition.TOP,
//             titleText: Text(
//               "Coming Soon!",
//               style: TextStyle(
//                 fontSize: 13,
//                 fontFamily: AppStrings.fontBold,
//                 color: AppColors.kPrimaryColor,
//               ),
//             ),
//             backgroundColor: AppColors.kPrimaryColorLight,
//             messageText: Text(
//               "This is not currently available",
//               style: TextStyle(
//                 fontSize: 11,
//                 fontFamily: AppStrings.fontLight,
//                 color: AppColors.kPrimaryColor,
//               ),
//             ),
//             duration: Duration(seconds: 3),
//           ).show(context),
//         ),
//       ],
//     ));
//   }
// }
