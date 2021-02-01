import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:zimvest/data/models/payment/card.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
import 'package:zimvest/data/view_models/wallets_view_model.dart';
import 'package:zimvest/new_screens/profile/widgets/verification_failed_widget.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/margins.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';

class InvestmentCardNaira extends StatelessWidget {
  final String investmentDuration;
  final String percentage;
  final String minimumAmount;
  final String maximumAmount;
  final double height;
  final double width;
  const InvestmentCardNaira({
    Key key,
    @required this.investmentDuration,
    @required this.percentage,
    @required this.minimumAmount,
    @required this.maximumAmount,
    this.height = 3,
    this.width = 1.3,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height / height,
        width: MediaQuery.of(context).size.width / width,
        margin: EdgeInsets.only(top: 25),
        padding: EdgeInsets.all(11),
        decoration: BoxDecoration(
            color: AppColors.kWhite,
            boxShadow: AppUtils.getBoxShaddow,
            borderRadius: BorderRadius.circular(11)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Zimvest High Yield Naira $investmentDuration",
              style: TextStyle(fontSize: 11, fontFamily: AppStrings.fontBold),
            ),
            YMargin(8),
            Text(
              "$percentage P.A",
              style: TextStyle(
                  fontSize: 11,
                  color: AppColors.kWealthDark,
                  fontFamily: AppStrings.fontMedium),
            ),
            Spacer(),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Minimum Amount",
                      style: TextStyle(
                          fontSize: 11,
                          fontFamily: AppStrings.fontNormal,
                          color: AppColors.kTextColor),
                    ),
                    YMargin(8),
                    Text(
                      "${AppStrings.nairaSymbol}$minimumAmount.00",
                      style: TextStyle(
                          fontSize: 11,
                          fontFamily: AppStrings.fontMedium,
                          color: AppColors.kTextColor),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Maximum Amount",
                      style: TextStyle(
                          fontSize: 11,
                          fontFamily: AppStrings.fontNormal,
                          color: AppColors.kTextColor),
                    ),
                    YMargin(8),
                    Text(
                      "Above ${AppStrings.nairaSymbol}$maximumAmount.00",
                      style: TextStyle(
                          fontSize: 11,
                          fontFamily: AppStrings.fontMedium,
                          color: AppColors.kTextColor),
                    ),
                  ],
                )
              ],
            ),
            YMargin(8)
          ],
        ),
      ),
    );
  }
}

class InvestmentCardDollar extends StatelessWidget {
  final String investmentDuration;
  final String percentage;
  final String minimumAmount;
  final String maximumAmount;
  final double height;
  final double width;

  const InvestmentCardDollar({
    Key key,
    @required this.investmentDuration,
    @required this.percentage,
    @required this.minimumAmount,
    @required this.maximumAmount,
    this.height = 3.5,
    this.width = 1.3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height / height,
        width: MediaQuery.of(context).size.width / width,
        margin: EdgeInsets.only(top: 25),
        padding: EdgeInsets.all(11),
        decoration: BoxDecoration(
            color: AppColors.kWhite,
            boxShadow: AppUtils.getBoxShaddow,
            borderRadius: BorderRadius.circular(11)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Zimvest High Yield Dollar $investmentDuration",
              style: TextStyle(fontSize: 11, fontFamily: AppStrings.fontBold),
            ),
            YMargin(8),
            Text(
              "$percentage P.A",
              style: TextStyle(
                  fontSize: 11,
                  color: AppColors.kWealthDark,
                  fontFamily: AppStrings.fontMedium),
            ),
            Spacer(),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Minimum Amount",
                      style: TextStyle(
                          fontSize: 11,
                          fontFamily: AppStrings.fontNormal,
                          color: AppColors.kTextColor),
                    ),
                    YMargin(8),
                    Text(
                      "${AppStrings.dollarSymbol}$minimumAmount.00",
                      style: TextStyle(
                          fontSize: 11,
                          fontFamily: AppStrings.fontMedium,
                          color: AppColors.kTextColor),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Maximum Amount",
                      style: TextStyle(
                          fontSize: 11,
                          fontFamily: AppStrings.fontNormal,
                          color: AppColors.kTextColor),
                    ),
                    YMargin(8),
                    Text(
                      "Above ${AppStrings.dollarSymbol}$maximumAmount.00",
                      style: TextStyle(
                          fontSize: 11,
                          fontFamily: AppStrings.fontMedium,
                          color: AppColors.kTextColor),
                    ),
                  ],
                )
              ],
            ),
            YMargin(8)
          ],
        ),
      ),
    );
  }
}

class FixedIncomeCard extends StatelessWidget {
  final String bondName;
  final double rate;
  final num minimumAmount;
  final String maturityDate;
  final double height;
  final double width;

  const FixedIncomeCard(
      {Key key,
      @required this.bondName,
      @required this.rate,
      @required this.minimumAmount,
      @required this.maturityDate,
      this.height = 70,
      this.width = 250})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: EdgeInsets.all(11),
        margin: EdgeInsets.only(top: 20),
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppColors.kWhite,
          boxShadow: AppUtils.getBoxShaddow,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bondName,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    fontFamily: AppStrings.fontNormal,
                    color: AppColors.kTextColor,
                  ),
                ),
                Text(
                  "${rate.toString()} %PA",
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppStrings.fontNormal,
                    color: AppColors.kFixed,
                  ),
                )
              ],
            ),
            YMargin(46),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Minimum Amount",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppStrings.fontNormal,
                        color: AppColors.kTextColor,
                      ),
                    ),
                    Text(
                      "${AppStrings.nairaSymbol} ${minimumAmount.toString().split('.')[0].convertWithComma()}",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppStrings.fontNormal,
                        color: AppColors.kTextColor,
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Maturity  Date",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppStrings.fontNormal,
                        color: AppColors.kTextColor,
                      ),
                    ),
                    Text(
                      "${maturityDate.toString()}",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppStrings.fontNormal,
                        color: AppColors.kTextColor,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SelectPaymentCardWidget extends StatefulWidget {
  const SelectPaymentCardWidget({
    Key key,
    this.success = true,
    this.navigate,
    this.cards,
  }) : super(key: key);

  final bool success;
  final VoidCallback navigate;
  final List<PaymentCard> cards;

  @override
  _SelectPaymentCardWidgetState createState() =>
      _SelectPaymentCardWidgetState();
}

class _SelectPaymentCardWidgetState extends State<SelectPaymentCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        children: [
          YMargin(10),
          Center(
            child: Container(
              width: 30,
              height: 5,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
            ),
          ),
          YMargin(20),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    YMargin(40),
                    Text(
                      "Select Card",
                      style: TextStyle(
                          fontSize: 15, fontFamily: AppStrings.fontBold),
                    ),
                    YMargin(27),
                    ...List.generate(
                      widget.cards.length,
                      (index) => CardItemWidget(
                        card: widget.cards[index],
                        navigate: widget.navigate,
                      ),
                    ),
                    Spacer(),
                    Center(
                      child: PrimaryButtonNew(
                        onTap: () {
                          //Navigator.pop(context);
                          // processTransaction();
                        },
                        title: "Add New Card",
                        width: 200,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // processTransaction() async {
  //   EasyLoading.show(status: "Initializing transaction");
  //   var result =
  //       await paymentViewModel.registerNewCard(identityViewModel.user.token);

  //   if (result.error == false) {
  //     EasyLoading.showSuccess("Success");
  //     setState(() {
  //       cardPayload = result.data;
  //     });

  //     Flutterwave flutterwave = Flutterwave.forUIPayment(
  //         context: this.context,
  //         encryptionKey: cardPayload.encKey,
  //         publicKey: cardPayload.pbfPubKey,
  //         currency: "NGN",
  //         amount: "100",
  //         email: cardPayload.customerEmail,
  //         fullName: identityViewModel.user.fullname,
  //         txRef: cardPayload.txref,
  //         isDebugMode: false,
  //         phoneNumber: cardPayload.customerPhone,
  //         acceptCardPayment: true,
  //         acceptUSSDPayment: true,
  //         acceptAccountPayment: false,
  //         acceptFrancophoneMobileMoney: false,
  //         acceptGhanaPayment: false,
  //         acceptMpesaPayment: false,
  //         acceptRwandaMoneyPayment: true,
  //         acceptUgandaPayment: false,
  //         acceptZambiaPayment: false);

  //     // Initialize and get the transaction result
  //     try {
  //       print("ppppmmmm i want to");
  //       final ChargeResponse response =
  //           await flutterwave.initializeForUiPayments();
  //       if (response == null) {
  //         // user didn't complete the transaction. Payment wasn't successful.
  //       } else {
  //         final isSuccessful = checkPaymentIsSuccessful(response);
  //         if (isSuccessful) {
  //           EasyLoading.show(status: "Loading");
  //           var result = await paymentViewModel.paymentConfirmation(
  //               identityViewModel.user.token, cardPayload.txref);
  //           if (result.error == false) {
  //             EasyLoading.showSuccess("Card Added");
  //           } else {
  //             EasyLoading.showError("Error occured");
  //           }
  //         } else {
  //           // check message
  //           print(response.message);
  //           EasyLoading.showError("Error occured");

  //           // check status
  //           print(response.status);

  //           // check processor error
  //           print(response.data.processorResponse);
  //         }
  //       }
  //     } catch (error, stacktrace) {
  //       EasyLoading.showError("Error occured");
  //       // handleError(error);
  //       print(error.toString());
  //     }
  //   }
  // }

  // processTransaction2() async {
  //   EasyLoading.show(status: "Initializing transaction");
  //   var result =
  //       await paymentViewModel.registerNewCard(identityViewModel.user.token);

  //   if (result.error == false) {
  //     EasyLoading.showSuccess("Success");
  //     setState(() {
  //       cardPayload = result.data;
  //     });
  //     var initializer = RavePayInitializer(
  //         amount: 100,
  //         publicKey: cardPayload.pbfPubKey,
  //         encryptionKey: cardPayload.encKey)
  //       ..country = "NG"
  //       ..currency = "NGN"
  //       ..email = cardPayload.customerEmail
  //       ..fName = cardPayload.customerFirstname
  //       ..lName = cardPayload.customerLastname
  //       ..narration = "Add card" ?? ''
  //       ..txRef = cardPayload.txref
  //       ..acceptCardPayments = true
  //       ..staging = true
  //       ..isPreAuth = false
  //       ..displayFee = true;

  //     // Initialize and get the transaction result
  //     RaveResult response = await RavePayManager()
  //         .prompt(context: context, initializer: initializer);
  //     print("response ${response.rawResponse}");
  //     if (response.status == RaveStatus.success) {
  //       EasyLoading.show(status: "Loading");
  //       var result = await paymentViewModel.paymentConfirmation(
  //           identityViewModel.user.token, cardPayload.txref);
  //       if (result.error == false) {
  //         await paymentViewModel.getUserCards(identityViewModel.user.token);
  //         EasyLoading.showSuccess("Card Added");
  //         Navigator.pop(context);
  //       } else {
  //         EasyLoading.showError("Error occured");
  //       }
  //     } else {
  //       EasyLoading.showError("Error occured");
  //     }
  //   }
  // }

  // bool checkPaymentIsSuccessful(final ChargeResponse response) {
  //   return response.data.status == FlutterwaveConstants.SUCCESSFUL &&
  //       response.data.currency == "NGN" &&
  //       response.data.amount == savingViewModel.amountToSave.toString() &&
  //       response.data.txRef == cardPayload.txref;
  // }
}
