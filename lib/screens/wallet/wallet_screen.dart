import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:zimvest/screens/tabs/invstment/investment_screen.dart';
import 'package:zimvest/screens/wallet/fund_wallet.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/widgets/appbars.dart';

class WalletScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => WalletScreen(),
        settings: RouteSettings(name: WalletScreen().toStringShort()));
  }
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBg,
      appBar: ZimAppBar(
        title: "My Wallet",
        desc: "You can manage your wallet here",
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(delegate: SliverChildListDelegate([
            Container(
              height: 136,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.kPrimaryColor
              ),
              child: Column(children: [
                YMargin(15),
                Text("My Wallet balance",
                  style: TextStyle(
                    color: AppColors.kLightText2,
                    fontSize: 12,
                  ),),
                YMargin(10),
                Text("\$ 10,000,000.00",
                  style: TextStyle(
                      color: AppColors.kWhite,
                      fontSize: 24,
                      fontFamily: "Caros-Medium"
                  ),),
                YMargin(15),
                Text("My Wallet ID",
                  style: TextStyle(
                    color: AppColors.kLightText2,
                    fontSize: 10,
                  ),),
                YMargin(5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("2134758794",
                      style: TextStyle(
                        color: AppColors.kWhite,
                        fontSize: 16,
                      ),),
                    XMargin(5),
                    SvgPicture.asset("images/copy.svg")
                  ],)
              ],),
            ),
            YMargin(10),
            Row(
              children: [
                XMargin(20),
                SavingsActionWidget(
                  width: 140,
                  title: "Fund your wallet",
                  onTap: (){
                    Navigator.of(context).push(FundWallet.route());
                  },
                ),
              ],
            ),
            YMargin(30),
            _buildSavingsActivities(),
            YMargin(20),
          ]),),
          SliverList(delegate: SliverChildListDelegate(
            List.generate(4, (index) {
              return Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: .5, color: AppColors.kLightText))),
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 55,
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Wallet funding",
                          style: TextStyle(
                              color: Color(0xFF324d53), fontSize: 12),
                        ),
                        YMargin(5),
                        Text(
                          "Mon, April 13 2020",
                          style: TextStyle(
                              fontSize: 10, color: AppColors.kLightText2),
                        )
                      ],
                    ),
                    Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "\$ 400.00",
                          style: TextStyle(
                              fontSize: 12, color: AppColors.kGreen),
                        ),
                        YMargin(5),
                        Text(
                          "Failed",
                          style: TextStyle(
                              fontSize: 10, color: AppColors.kLightText2),
                        )
                      ],
                    )
                  ],
                ),
              );
            })
          ),)
        ],
      ),
    );
  }

  Widget _buildSavingsActivities() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Recent activities",
            style: TextStyle(
                fontSize: 16,
                fontFamily: "Caros-Bold",
                color: AppColors.kPrimaryColor2),
          ),
          InkWell(
            onTap: () {
              showCupertinoModalBottomSheet(
                context: context,
                builder: (context, scrollController) => Container(
                  child: Scaffold(body: CustomScrollView(
                    slivers: [
                      SliverList(delegate: SliverChildListDelegate([
                        YMargin(30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(children: [
                            Text(
                              "All activities",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Caros-Bold",
                                  color: AppColors.kPrimaryColor2),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: (){
                                Navigator.of(context).pop();
                              },
                              child: Text("Collapse",style: TextStyle(
                                  fontFamily: "Caros-Medium",
                                  fontSize: 12,
                                  color: AppColors.kAccentColor),),
                            )
                          ],),
                        ),
                        YMargin(20),

                      ]),),
                      SliverList(delegate: SliverChildListDelegate(
                          List.generate(20, (index) {
                            return Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: .5, color: AppColors.kLightText))),
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              height: 55,
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Wallet funding",
                                        style: TextStyle(
                                            color: Color(0xFF324d53), fontSize: 12),
                                      ),
                                      YMargin(5),
                                      Text(
                                        "Mon, April 13 2020",
                                        style: TextStyle(
                                            fontSize: 10, color: AppColors.kLightText2),
                                      )
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "\$ 400.00",
                                        style: TextStyle(
                                            fontSize: 12, color: AppColors.kGreen),
                                      ),
                                      YMargin(5),
                                      Text(
                                        "Failed",
                                        style: TextStyle(
                                            fontSize: 10, color: AppColors.kLightText2),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          })
                      ),)
                    ],
                  ),),
                ),
              );
            },
            child: Container(
              child: Row(
                children: [
                  Text(
                    "See all",
                    style: TextStyle(
                        fontFamily: "Caros-Medium",
                        fontSize: 12,
                        color: AppColors.kAccentColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
