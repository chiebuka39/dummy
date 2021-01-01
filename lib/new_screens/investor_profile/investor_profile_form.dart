import 'package:flutter/material.dart';
import 'package:zimvest/new_screens/investor_profile/result_sent_screen.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/navigation/checkBox.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

class InvestorProfileForm extends StatefulWidget {

  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => InvestorProfileForm(),
        settings:
        RouteSettings(name: InvestorProfileForm().toStringShort()));
  }
  @override
  _InvestorProfileFormState createState() => _InvestorProfileFormState();
}

class _InvestorProfileFormState extends State<InvestorProfileForm> {

  PageController controller = PageController();
  int currentPage = 0;
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        if(currentPage == 0){
          return true;
        }else{
          setState(() {
            currentPage = currentPage -1;
          });
          controller.animateToPage(currentPage,
              duration: Duration(milliseconds: 300),curve: Curves.easeIn);
          return false;
        }
      },
      child: Scaffold(
        appBar: ZimAppBar(
          icon: Icons.arrow_back_ios,
          text: "Investor Profile",
          callback: (){
            if(currentPage == 0){
              Navigator.pop(context);
            }else{
              setState(() {
                currentPage = currentPage -1;
              });
              controller.animateToPage(currentPage,
                  duration: Duration(milliseconds: 300),curve: Curves.easeIn);
            }

          },
        ),
        body: Column(
          children: [
            YMargin(30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                Expanded(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: 4,
                    decoration: BoxDecoration(
                        color:currentPage == 0 ? AppColors.kPrimaryColor: AppColors.kLightTitleText),
                  ),
                ),
                XMargin(13),
                Expanded(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: 4,
                    decoration: BoxDecoration(
                        color:currentPage == 1 ? AppColors.kPrimaryColor:  AppColors.kLightTitleText),
                  ),
                ),
                  XMargin(13),
                Expanded(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: 4,
                    decoration: BoxDecoration(
                        color:currentPage == 2 ? AppColors.kPrimaryColor:  AppColors.kLightTitleText),
                  ),
                ),
                  XMargin(13),
                Expanded(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: 4,
                    decoration: BoxDecoration(
                        color: currentPage == 3 ? AppColors.kPrimaryColor:  AppColors.kLightTitleText),
                  ),
                ),
                  XMargin(13),
                Expanded(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: 4,
                    decoration: BoxDecoration(
                        color:currentPage == 4 ? AppColors.kPrimaryColor:  AppColors.kLightTitleText),
                  ),
                ),
                  XMargin(13),
                Expanded(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: 4,
                    decoration: BoxDecoration(
                        color:currentPage == 5 ? AppColors.kPrimaryColor:  AppColors.kLightTitleText),
                  ),
                ),
                  XMargin(13),
                Expanded(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: 4,
                    decoration: BoxDecoration(
                        color:currentPage == 6 ? AppColors.kPrimaryColor:  AppColors.kLightTitleText),
                  ),
                ),
              ],),
            ),
            YMargin(30),
            Expanded(
              child: Container(
                child: PageView(
                  controller: controller,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(children: [
                        Text("How would you describe your knowledge of investment", style: TextStyle(
                            fontSize: 15, fontFamily: AppStrings.fontBold
                        ),),
                        SelectorWidget(
                          top: 20,
                          title: 'Not knowledgible',
                          selected: false,
                        ),
                        SelectorWidget(
                          top: 20,
                          title: 'Basic knowledge',
                          selected: false,
                        ),
                        SelectorWidget(
                          top: 20,
                          title: 'Good knowledge',
                          selected: false,
                        ),
                        SelectorWidget(
                          top: 20,
                          title: 'Experienced investor',
                          selected: false,
                        ),
                      ],),),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(children: [
                      Text("What are you the most concerned "
                          "about when investing", style: TextStyle(
                        fontSize: 15, fontFamily: AppStrings.fontBold
                      ),),
                        SelectorWidget(
                          title: 'Mostly concerned about my investment losing value',
                          selected: false,
                        ),
                        SelectorWidget(
                          title: 'Equally concerned about my investment losing or gaining value',
                          selected: false,
                        ),
                        SelectorWidget(
                          title: 'Most concerned about my investment gaining value',
                          selected: false,
                        ),
                    ],),),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(children: [
                      Text("Which of the following investments do "
                          "you currently own?", style: TextStyle(
                        fontSize: 15, fontFamily: AppStrings.fontBold
                      ),),
                        SelectorWidget(
                          top: 20,
                          title: 'None',
                          selected: false,
                        ),
                        SelectorWidget(
                          top: 20,
                          title: 'Fixed Deposit',
                          selected: false,
                        ),
                        SelectorWidget(
                          top: 20,
                          title: 'Stocks',
                          selected: false,
                        ),
                        SelectorWidget(
                          top: 20,
                          title: 'Foreign Securities',
                          selected: false,
                        ),
                    ],),),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(children: [
                      Text("Imagine the overall stock market drops by 20% "
                          "and a particular sotck you own also drops by 20%, what will you do?", style: TextStyle(
                        fontSize: 15, fontFamily: AppStrings.fontBold,height: 1.7
                      ),),
                        SelectorWidget(
                          top: 20,
                          title: 'Sell all of my shares',
                          selected: false,
                        ),
                        SelectorWidget(
                          top: 20,
                          title: 'Sell some of my shares',
                          selected: false,
                        ),
                        SelectorWidget(
                          top: 20,
                          title: 'Do nothing',
                          selected: false,
                        ),
                        SelectorWidget(
                          top: 20,
                          title: 'Buy more shares',
                          selected: false,
                        ),
                    ],),),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: SingleChildScrollView(
                        child: Column(children: [
                        Text("Which of the following hypothethical investment plans will you choose?", style: TextStyle(
                          fontSize: 15, fontFamily: AppStrings.fontBold,height: 1.7
                        ),),
                          SelectorWidget(
                            height: 70,
                            title: 'Average Annual Return = 7%\nBest Case = 16.0%\nWorst Case = -6%',
                            selected: false,
                          ),
                          SelectorWidget(
                            height: 70,
                            title: 'Average Annual Return = 9%\nBest Case = 25.0%\nWorst Case = -12%',
                            selected: false,
                          ),
                          SelectorWidget(
                            height: 70,
                            title: 'Average Annual Return = 11%\nBest Case = 34.0%\nWorst Case = -18%',
                            selected: false,
                          ),
                          SelectorWidget(
                            height: 70,
                            title: 'Average Annual Return = 12%\nBest Case = 43.0%\nWorst Case = -24%',
                            selected: false,
                          ),
                          SelectorWidget(
                            height: 70,
                            title: 'Average Annual Return = 12%\nBest Case = 43.0%\nWorst Case = -24%',
                            selected: false,
                          ),



                    ],),
                      ),),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(children: [
                        Text("How long do you plan to invest before you start making withdrawals", style: TextStyle(
                            fontSize: 15, fontFamily: AppStrings.fontBold,height: 1.7
                        ),),
                        SelectorWidget(
                          top: 20,
                          title: 'Less than 3 years',
                          selected: false,
                        ),
                        SelectorWidget(
                          top: 20,
                          title: '3 - 5 years',
                          selected: false,
                        ),
                        SelectorWidget(
                          top: 20,
                          title: '6 - 10 years',
                          selected: false,
                        ),
                        SelectorWidget(
                          top: 20,
                          title: '11 years or more',
                          selected: false,
                        ),
                      ],),),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(children: [
                        Text("Over how many years do you plan to completely withdraw", style: TextStyle(
                            fontSize: 15, fontFamily: AppStrings.fontBold,height: 1.7
                        ),),
                        SelectorWidget(
                          top: 20,
                          title: 'Less than 3 years',
                          selected: false,
                        ),
                        SelectorWidget(
                          top: 20,
                          title: '3 - 5 years',
                          selected: false,
                        ),
                        SelectorWidget(
                          top: 20,
                          title: '6 - 10 years',
                          selected: false,
                        ),
                        SelectorWidget(
                          top: 20,
                          title: '11 years or more',
                          selected: false,
                        ),
                      ],),),
                  ],
                ),
              ),
            ),
            YMargin(50),
            RoundedNextButton(
              onTap: (){
                if(currentPage == 6){
                  Navigator.push(context, ResultSentScreen.route());
                  return;
                }
                setState(() {
                  currentPage = currentPage +1;
                });
                controller.animateToPage(currentPage,
                    duration: Duration(milliseconds: 300),curve: Curves.easeIn);
              },
            ),
            YMargin(50),

          ],
        ),
      ),
    );
  }
}

class SelectorWidget extends StatelessWidget {
  const SelectorWidget({
    Key key, this.selected, this.title, this.top = 32, this.height = 50,
  }) : super(key: key);

  final bool selected;
  final String title;
  final double top;
  final double height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){

      },
      child: Container(
        height: height,
        margin: EdgeInsets.only(top: top),
        child: Row(
          children: [
            SizedBox(
              width: 270,
                child: Text(title, style: TextStyle(fontSize: 13, fontFamily: AppStrings.fontNormal,height: 1.7),)),
            Spacer(),
            AnimatedSwitcher(
                duration: Duration(milliseconds: 600),
                child: selected?check: checkEmpty)
          ],
        ),
      ),
    );
  }
}
