import 'package:flutter/material.dart';
import 'package:zimvest/new_screens/navigation/investments/see_all_investments.dart';
import 'package:zimvest/new_screens/navigation/investments/widgets/card_widget.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';

class HighYieldDollarScreen extends StatefulWidget {
  @override
  _HighYieldDollarScreenState createState() => _HighYieldDollarScreenState();
}

class _HighYieldDollarScreenState extends State<HighYieldDollarScreen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "30 Days",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: AppStrings.fontMedium,
                          color: AppColors.kTextColor),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, AllDollarInvestments.route("30"));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "See all",
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: AppStrings.fontMedium,
                                color: AppColors.kPrimaryColor),
                          ),
                          Icon(Icons.arrow_forward_ios,
                              size: 15, color: AppColors.kPrimaryColor)
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: 15,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => InvestmentCardDollar(
                            investmentDuration: "30",
                            percentage: "6.67",
                            minimumAmount: "5,000,000",
                            maximumAmount: "50,000,000",
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          YMargin(30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "60 Days",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: AppStrings.fontMedium,
                          color: AppColors.kTextColor),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, AllDollarInvestments.route("60"));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "See all",
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: AppStrings.fontMedium,
                                color: AppColors.kPrimaryColor),
                          ),
                          Icon(Icons.arrow_forward_ios,
                              size: 15, color: AppColors.kPrimaryColor)
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: 15,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => InvestmentCardDollar(
                            investmentDuration: "60",
                            percentage: "6.67",
                            minimumAmount: "5,000,000",
                            maximumAmount: "50,000,000",
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          YMargin(30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "90 Days",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: AppStrings.fontMedium,
                          color: AppColors.kTextColor),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, AllDollarInvestments.route("90"));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "See all",
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: AppStrings.fontMedium,
                                color: AppColors.kPrimaryColor),
                          ),
                          Icon(Icons.arrow_forward_ios,
                              size: 15, color: AppColors.kPrimaryColor)
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: 15,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => InvestmentCardDollar(
                            investmentDuration: "90",
                            percentage: "6.67",
                            minimumAmount: "5,000,000",
                            maximumAmount: "50,000,000",
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          YMargin(30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "180 Days",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: AppStrings.fontMedium,
                          color: AppColors.kTextColor),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, AllDollarInvestments.route("180"));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "See all",
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: AppStrings.fontMedium,
                                color: AppColors.kPrimaryColor),
                          ),
                          Icon(Icons.arrow_forward_ios,
                              size: 15, color: AppColors.kPrimaryColor)
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: 15,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => InvestmentCardDollar(
                            investmentDuration: "180",
                            percentage: "6.67",
                            minimumAmount: "5,000,000",
                            maximumAmount: "50,000,000",
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          YMargin(30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "270 Days",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: AppStrings.fontMedium,
                          color: AppColors.kTextColor),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, AllDollarInvestments.route("270"));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "See all",
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: AppStrings.fontMedium,
                                color: AppColors.kPrimaryColor),
                          ),
                          Icon(Icons.arrow_forward_ios,
                              size: 15, color: AppColors.kPrimaryColor)
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: 15,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => InvestmentCardDollar(
                            investmentDuration: "270",
                            percentage: "6.67",
                            minimumAmount: "5,000,000",
                            maximumAmount: "50,000,000",
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          YMargin(30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "365 Days",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: AppStrings.fontMedium,
                          color: AppColors.kTextColor),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, AllDollarInvestments.route("365"));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "See all",
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: AppStrings.fontMedium,
                                color: AppColors.kPrimaryColor),
                          ),
                          Icon(Icons.arrow_forward_ios,
                              size: 15, color: AppColors.kPrimaryColor)
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: 15,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => InvestmentCardDollar(
                            investmentDuration: "365",
                            percentage: "6.67",
                            minimumAmount: "5,000,000",
                            maximumAmount: "50,000,000",
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
