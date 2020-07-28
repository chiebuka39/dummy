import 'package:flutter/material.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/widgets/appbars.dart';
import 'package:zimvest/widgets/buttons.dart';

class InvestmentProfileScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => InvestmentProfileScreen(),
        settings: RouteSettings(name: InvestmentProfileScreen().toStringShort()));
  }
  @override
  _InvestmentProfileScreenState createState() => _InvestmentProfileScreenState();
}

class _InvestmentProfileScreenState extends State<InvestmentProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ZimAppBar(title:"Investor Profile",),
      backgroundColor: AppColors.kLightBG,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          Text("Please read and tick the most appropriate answer to the questions below. "
              "Your responses will enable us identify the investor "
              "profile that best suits you.", style: TextStyle(color: AppColors.kAccountTextColor,
              fontSize: 10),),
          YMargin(20),
          Container(
            height: 50,
            child: Column(children: [
              Container(
                height: .4,
                color: AppColors.kLightTitleText,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 11),
                child: Text("5% Complete", style:  TextStyle(fontSize: 12,
                    color: AppColors.kAccountTextColor),),

              ),
              Container(
                height: 6,
                child: Stack(children: [
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 300),
                    left:0,
                    child: Container(
                      height: 6,
                      width: 47,
                      color: AppColors.kAccentColor,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: .4,
                      color: AppColors.kLightTitleText,
                    ),
                  )
                ],),
                color: Colors.transparent,
              ),
            ],),
          ),
          Expanded(
            child: PageView(
              children: [
                KnowledgeDescriptionWidget(
                  first: true,
                  question: "1. How would you describe your knowledge of",
                  options: [
                    "Not Knowledgible",
                    "Basic Knowledge",
                    "Good knowledge",
                    "Experienced investor"
                  ],
                ),

                ConcernedDescriptionWidget(),
                KnowledgeDescriptionWidget(
                  question: "3. Which of the following investments do you currently own?",
                  options: [
                    "None",
                    "Fixed Deposit",
                    "Stocks",
                    "Foreign Securities"
                  ],
                ),
                KnowledgeDescriptionWidget(
                  question: "4. Imagine the overall stock market drops by 20% "
                      "and a particular stock you own also drops by 20%, what will you do?",
                  options: [
                    "Sell all of my shares ",
                    "Sell some of my shares ",
                    "Do nothing",
                    "Buy more shares "
                  ],
                ),
                KnowledgeDescriptionWidget(
                  height: 70,
                  question: "5.Which of the following hypothetical investment plans will you choose??",
                  options: [
                    """Average Annual Return = 7% \nBest Case = 16.0%\nWorst Case = -6%""",
                    "Average Annual Return = 7%\nBest Case = 16.0%\nWorst Case = -6% ",
                    "Average Annual Return = 7%\nBest Case = 16.0%\nWorst Case = -6%",
                    "Average Annual Return = 12%\nBest Case = 43%\nWorst Case = -24%",
                    "Average Annual Return = 13%\nBest Case = 50%\nWorst Case = -28%"
                  ],
                ),
                KnowledgeDescriptionWidget(
                  question: "6. How long do you plan to invest before you start making withdrawals?",
                  options: [
                    "Less than 3 years ",
                    "3–5 years ",
                    "6–10 years ",
                    "11 years or more"
                  ],
                ),
                KnowledgeDescriptionWidget(
                  question: "7. Over how many years do you plan to completely withdraw all your investments?",
                  options: [
                    "Less than 3 years ",
                    "2–5 years ",
                    "6–10 years ",
                    "11 years or more"
                  ],
                ),
              ],
            ),
          )
        ],),
      ),
    );
  }
}

class KnowledgeDescriptionWidget extends StatelessWidget {
  final String question;
  final double height;
  final bool first;
  final List<String> options;
  const KnowledgeDescriptionWidget({
    Key key, this.question, this.options, this.height = 50, this.first = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        YMargin(10),
      Text(question,
        style: TextStyle(color: AppColors.kAccountTextColor, fontSize: 12),),
        for(var i in options)
          CustomSelectorRow(title: i,isSelected: false,height: height,),

        Spacer(),
        first == false ?Row(children: [
          Expanded(child: OutlinePrimaryButton(
            title: "Previous",
            onPressed: (){},
          ),
          ),
          SizedBox(width: 20,),
          Expanded(child: PrimaryButton(
            title: "Next",
            onPressed: (){},
          ),
          )
        ],): PrimaryButton(
          title: "Next",
          onPressed: (){
            
          },
        )
    ],);
  }
}
class ConcernedDescriptionWidget extends StatelessWidget {
  const ConcernedDescriptionWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        YMargin(10),
      Text("2. What are you most concerned about when investing?",
        style: TextStyle(color: AppColors.kAccountTextColor, fontSize: 12),),
        CustomSelectorRow(title: "Most concerned about my  investment losing value ",isSelected: true,),
        CustomSelectorRow(title: "Equally concerned about my  investment losing or gaining value ",isSelected: false,),
        CustomSelectorRow(title: "Most concerned about my  investment gaining value ",isSelected: false,),

        Spacer(),
        PrimaryButton(
          title: "Next",
          onPressed: (){

          },
        )
    ],);
  }
}

class CustomSelectorRow extends StatelessWidget {
  final String title;
  final bool isSelected;
  final double height;
  const CustomSelectorRow({
    Key key, this.title, this.isSelected = false, this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.kLightText))
      ),
      height: height,
      child: Row(children: [
        SizedBox(
          width: MediaQuery.of(context).size.width -100,
            child: Text(title, style: TextStyle(fontSize: 12, color: AppColors.kAccountTextColor),)),
        Spacer(),
        CustomCheckBox(selected: isSelected,)
      ],),
    );
  }
}

class CustomCheckBox extends StatelessWidget {
  final bool selected;
  const CustomCheckBox({
    Key key, this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22,
      width: 22,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: AppColors.kAccentColor)
      ),
      child: Center(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: 16,
          width: 16,
          decoration: BoxDecoration(
            color: selected ? AppColors.kAccentColor:Colors.transparent,
            borderRadius: BorderRadius.circular(5)
          ),
        ),
      ),
    );
  }
}
