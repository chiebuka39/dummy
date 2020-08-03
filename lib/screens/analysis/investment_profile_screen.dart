import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  int count = 0;
  int total = 7;

  PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ZimAppBar(title:"Investor Profile",),
      backgroundColor: AppColors.kLightBG,
      body: Column(children: [
        YMargin(20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text("Please read and tick the most appropriate answer to the questions below. "
              "Your responses will enable us identify the investor "
              "profile that best suits you.", style: TextStyle(color: AppColors.kAccountTextColor,
              fontSize: 10),),
        ),
        YMargin(20),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: 50,
          child: Column(children: [
            Container(
              height: .4,
              color: AppColors.kLightTitleText,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 11),
              child: Text("${((count/7) * 100).toInt()}% Complete", style:  TextStyle(fontSize: 12,
                  color: AppColors.kAccountTextColor),),

            ),
            Container(
              height: 6,
              child: Stack(children: [
                AnimatedPositioned(
                  duration: Duration(milliseconds: 300),
                  left:(count *47).toDouble(),
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
            controller: _controller,
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
                nextClicked: (){
                  moveToNext();
                },
              ),
              KnowledgeDescriptionWidget(
                first: false,
                question: "2. What are you most concerned about when investing?",
                options: [
                  "Most concerned about my investment losing value ",
                  "Equally concerned about my investment losing or gaining value ",
                  "Most concerned about my investment gaining value",
                ],
                nextClicked: (){
                  moveToNext();
                },
                prevClicked: (){
                  goPrevious();
                },
              ),

              KnowledgeDescriptionWidget(
                question: "3. Which of the following investments do you currently own?",
                options: [
                  "None",
                  "Fixed Deposit",
                  "Stocks",
                  "Foreign Securities"
                ],
                nextClicked: (){
                  moveToNext();
                },
                prevClicked: (){
                  goPrevious();
                },
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
                nextClicked: (){
                  moveToNext();
                },
                prevClicked: (){
                  goPrevious();
                },
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
                nextClicked: (){
                  moveToNext();
                },
                prevClicked: (){
                  goPrevious();
                },
              ),
              KnowledgeDescriptionWidget(
                question: "6. How long do you plan to invest before you start making withdrawals?",
                options: [
                  "Less than 3 years ",
                  "3–5 years ",
                  "6–10 years ",
                  "11 years or more"
                ],
                nextClicked: (){
                  moveToNext();
                },
                prevClicked: (){
                  goPrevious();
                },
              ),
              KnowledgeDescriptionWidget(
                question: "7. Over how many years do you plan to completely withdraw all your investments?",
                options: [
                  "Less than 3 years ",
                  "2–5 years ",
                  "6–10 years ",
                  "11 years or more"
                ],
                submitClicked: (){
                  showModalBottomSheet(context: context, builder: (context){
                    return Container(
                      color: AppColors.kLightBG,
                      height: 375,
                      child: Column(children: [
                        YMargin(20),
                        SvgPicture.asset("images/wrong.svg", height: 70,),
                        YMargin(32),
                        Text("Results sent", style: TextStyle(
                            color: AppColors.kAccountTextColor,
                          fontSize: 20,fontFamily: "Caros-Bold"
                        ),),
                        YMargin(16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text('Your Investment Persona Analysis result has be '
                              'sent to your email address. Please check your mailbox.\n\nYou will need to check you '
                              'spam, if you can’t find it in your inbox.',
                            style: TextStyle(fontSize: 12,height: 1.7, color: AppColors.kAccountTextColor),textAlign: TextAlign.center,),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(children: [
                            Expanded(child: OutlinePrimaryButton(
                              title: "Retake Test",
                              onPressed: (){},
                            ),
                            ),
                            SizedBox(width: 20,),
                            Expanded(child: PrimaryButton(
                              title: "Go Home",
                              onPressed:(){},
                            ),
                            )
                          ],),
                        ),
                        YMargin(20)
                      ],),
                    );
                  });
                },
                last: true,
                prevClicked: (){
                  goPrevious();
                },
              ),
            ],
          ),
        )
      ],),
    );
  }

  void goPrevious() {
    setState(() {
      count = count -1;
    });
    _controller.animateToPage(count,
        duration: Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  void moveToNext() {
    setState(() {
      count = count +1;
    });
    _controller.animateToPage(count,
        duration: Duration(milliseconds: 300), curve: Curves.easeIn);
  }
}

class KnowledgeDescriptionWidget extends StatelessWidget {
  final String question;
  final double height;
  final bool first;
  final bool last;
  final VoidCallback nextClicked;
  final VoidCallback submitClicked;
  final VoidCallback prevClicked;
  final List<String> options;
  const KnowledgeDescriptionWidget({
    Key key, this.question, this.options, this.height = 50,
    this.first = false, this.nextClicked, this.prevClicked, this.last = false, this.submitClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
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
              onPressed: prevClicked,
            ),
            ),
            SizedBox(width: 20,),
            Expanded(child: PrimaryButton(
              title: last == true ?"Submit": "Next",
              onPressed:last == true ?submitClicked: nextClicked,
            ),
            )
          ],): PrimaryButton(
            title: "Next",
            onPressed: nextClicked,
          ),
          YMargin(20)
      ],),
    );
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
