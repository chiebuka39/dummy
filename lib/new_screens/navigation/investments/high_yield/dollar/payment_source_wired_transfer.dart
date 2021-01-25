import 'package:flutter/material.dart';
import 'package:zimvest/new_screens/navigation/investments/high_yield/dollar/upload_proof_of_payment.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/margins.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/navigation/delete_wealthbox.dart';

class WiredTransferScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (_) => WiredTransferScreen(),
      settings: RouteSettings(
        name: WiredTransferScreen().toStringShort(),
      ),
    );
  }

  @override
  _WiredTransferScreenState createState() => _WiredTransferScreenState();
}

class _WiredTransferScreenState extends State<WiredTransferScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.kPrimaryColor,
            ),
            onPressed: () => Navigator.pop(context)),
        actions: [
          FlatButton(
            child: Text(
              "Cancel",
              style: TextStyle(
                  fontSize: 12,
                  fontFamily: AppStrings.fontMedium,
                  color: AppColors.kPrimaryColor),
            ),
            onPressed: () {
              showModalBottomSheet<Null>(
                  context: context,
                  builder: (BuildContext context) {
                    return CancelAction();
                  },
                  isScrollControlled: true);
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YMargin(69),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              "Wired Transfer",
              style: TextStyle(
                fontSize: 15,
                fontFamily: AppStrings.fontBold,
                color: AppColors.kTextColor,
              ),
            ),
          ),
          YMargin(22),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              padding:
                  EdgeInsets.only(left: 27, right: 26, top: 29, bottom: 28),
              height: screenHeight(context) / 1.7,
              width: screenWidth(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.kWhite,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 1,
                    color: Color(0x20000000),
                    spreadRadius: -0.1,
                    offset: Offset(1.5, 1.5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Wired Transfer Details",
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: AppStrings.fontBold,
                      color: AppColors.kTextColor,
                    ),
                  ),
                  YMargin(10),
                  Text(
                    "Kindly note that this mode of payment may 2 - 5 working days depending on your bank",
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: AppStrings.fontNormal,
                      color: AppColors.kTextColor,
                    ),
                  ),
                  YMargin(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Beneficiary name:",
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: AppStrings.fontBold,
                          color: AppColors.kTextColor,
                        ),
                      ),
                      Container(
                        width: screenWidth(context) / 2,
                        child: Text(
                          "ZEDCREST INVESTMENT MANAGERS LIMITED",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: AppStrings.fontNormal,
                            color: AppColors.kTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  YMargin(25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Beneficiary address:",
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: AppStrings.fontBold,
                          color: AppColors.kTextColor,
                        ),
                      ),
                      Container(
                        width: screenWidth(context) / 2.15,
                        child: Text(
                          "177A Ligali Ayorinde, Victoria Island,Lagos",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: AppStrings.fontNormal,
                            color: AppColors.kTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  YMargin(25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Beneficiary bank:",
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: AppStrings.fontBold,
                          color: AppColors.kTextColor,
                        ),
                      ),
                      Container(
                        width: screenWidth(context) / 2.15,
                        child: Text(
                          "First City Monument Bank  Limited",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: AppStrings.fontNormal,
                            color: AppColors.kTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  YMargin(25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Beneficiary account number:",
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: AppStrings.fontBold,
                          color: AppColors.kTextColor,
                        ),
                      ),
                      Container(
                        width: screenWidth(context) / 3.15,
                        child: Text(
                          "6643633035",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: AppStrings.fontNormal,
                            color: AppColors.kTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  YMargin(25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Account number:",
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: AppStrings.fontBold,
                          color: AppColors.kTextColor,
                        ),
                      ),
                      Container(
                        width: screenWidth(context) / 2.15,
                        child: Text(
                          "0101254445850",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: AppStrings.fontNormal,
                            color: AppColors.kTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  YMargin(25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Swit code:",
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: AppStrings.fontBold,
                          color: AppColors.kTextColor,
                        ),
                      ),
                      Container(
                        width: screenWidth(context) / 2.15,
                        child: Text(
                          "FCMBNGLA",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: AppStrings.fontNormal,
                            color: AppColors.kTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  YMargin(25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Bank address:",
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: AppStrings.fontBold,
                          color: AppColors.kTextColor,
                        ),
                      ),
                      Container(
                        width: screenWidth(context) / 2.15,
                        child: Text(
                          "17a Tinubu Street, Lagos Island, Lagos, Nigeria",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: AppStrings.fontNormal,
                            color: AppColors.kTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          YMargin(58),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 87),
            child: PrimaryButtonNew(
              title: "I have made payment",
              onTap: () => Navigator.push(
                context,
                UploadProofOfPayment.route(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
