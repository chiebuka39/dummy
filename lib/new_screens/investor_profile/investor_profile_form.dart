import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/local/user_local.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/settings_view_model.dart';
import 'package:zimvest/locator.dart';
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
  bool loading = false;
  List<int> ips = [-1,-1,-1,-1,-1,-1,-1];

  ABSSettingsViewModel settingsViewModel;
  ABSIdentityViewModel identityViewModel;
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    identityViewModel = Provider.of(context);
    settingsViewModel = Provider.of(context);
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
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(children: [
                        Text("How would you describe your knowledge of investment", style: TextStyle(
                            fontSize: 15, fontFamily: AppStrings.fontBold
                        ),),
                        SelectorWidget(
                          callback: (){
                            setState(() {
                              ips[0] = 1;
                            });
                          },
                          top: 20,
                          title: 'Not knowledgible',
                          selected: ips[0] == 1,
                        ),
                        SelectorWidget(
                          callback: (){
                            setState(() {
                              ips[0] = 2;
                            });
                          },
                          selected: ips[0] == 2,
                          top: 20,
                          title: 'Basic knowledge',

                        ),
                        SelectorWidget(
                          top: 20,
                          title: 'Good knowledge',
                          callback: (){
                            setState(() {
                              ips[0] = 3;
                            });
                          },
                          selected: ips[0] == 3,
                        ),
                        SelectorWidget(
                          top: 20,
                          title: 'Experienced investor',
                          callback: (){
                            setState(() {
                              ips[0] = 4;
                            });
                          },
                          selected: ips[0] == 4,
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
                          callback: (){
                            setState(() {
                              ips[1] = 1;
                            });
                          },
                          selected: ips[1] == 1,
                        ),
                        SelectorWidget(
                          title: 'Equally concerned about my investment losing or gaining value',
                          callback: (){
                            setState(() {
                              ips[1] = 2;
                            });
                          },
                          selected: ips[1] == 2,
                        ),
                        SelectorWidget(
                          title: 'Most concerned about my investment gaining value',
                          callback: (){
                            setState(() {
                              ips[1] = 3;
                            });
                          },
                          selected: ips[1] == 3,
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
                          callback: (){
                            setState(() {
                              ips[2] = 1;
                            });
                          },
                          selected: ips[2] == 1,
                        ),
                        SelectorWidget(
                          top: 20,
                          title: 'Fixed Deposit',
                          callback: (){
                            setState(() {
                              ips[2] = 2;
                            });
                          },
                          selected: ips[2] == 2,
                        ),
                        SelectorWidget(
                          top: 20,
                          title: 'Stocks',
                          callback: (){
                            setState(() {
                              ips[2] = 3;
                            });
                          },
                          selected: ips[2] == 3,
                        ),
                        SelectorWidget(
                          top: 20,
                          title: 'Foreign Securities',
                          callback: (){
                            setState(() {
                              ips[2] = 4;
                            });
                          },
                          selected: ips[2] == 4,
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
                          callback: (){
                            setState(() {
                              ips[3] = 1;
                            });
                          },
                          selected: ips[3] == 1,
                        ),
                        SelectorWidget(
                          top: 20,
                          title: 'Sell some of my shares',
                          callback: (){
                            setState(() {
                              ips[3] = 2;
                            });
                          },
                          selected: ips[3] == 2,
                        ),
                        SelectorWidget(
                          top: 20,
                          title: 'Do nothing',
                          callback: (){
                            setState(() {
                              ips[3] = 3;
                            });
                          },
                          selected: ips[3] == 3,
                        ),
                        SelectorWidget(
                          top: 20,
                          title: 'Buy more shares',
                          callback: (){
                            setState(() {
                              ips[3] = 4;
                            });
                          },
                          selected: ips[3] == 4,
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
                            callback: (){
                              setState(() {
                                ips[4] = 1;
                              });
                            },
                            selected: ips[4] == 1,
                          ),
                          SelectorWidget(
                            height: 70,
                            title: 'Average Annual Return = 9%\nBest Case = 25.0%\nWorst Case = -12%',
                            callback: (){
                              setState(() {
                                ips[4] = 2;
                              });
                            },
                            selected: ips[4] == 2,
                          ),
                          SelectorWidget(
                            height: 70,
                            title: 'Average Annual Return = 11%\nBest Case = 34.0%\nWorst Case = -18%',
                            callback: (){
                              setState(() {
                                ips[4] = 3;
                              });
                            },
                            selected: ips[4] == 3,
                          ),
                          SelectorWidget(
                            height: 70,
                            title: 'Average Annual Return = 12%\nBest Case = 43.0%\nWorst Case = -24%',
                            callback: (){
                              setState(() {
                                ips[4] = 4;
                              });
                            },
                            selected: ips[4] == 4,
                          ),
                          SelectorWidget(
                            height: 70,
                            title: 'Average Annual Return = 13%\nBest Case = 50.0%\nWorst Case = -28%',
                            callback: (){
                              setState(() {
                                ips[4] = 5;
                              });
                            },
                            selected: ips[4] == 5,
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
                          callback: (){
                            setState(() {
                              ips[5] = 1;
                            });
                          },
                          selected: ips[5] == 1,

                        ),
                        SelectorWidget(
                          top: 20,
                          title: '3 - 5 years',
                          callback: (){
                            setState(() {
                              ips[5] = 2;
                            });
                          },
                          selected: ips[5] == 2,
                        ),
                        SelectorWidget(
                          top: 20,
                          title: '6 - 10 years',
                          callback: (){
                            setState(() {
                              ips[5] = 3;
                            });
                          },
                          selected: ips[5] == 3,
                        ),
                        SelectorWidget(
                          top: 20,
                          title: '11 years or more',
                          callback: (){
                            setState(() {
                              ips[5] = 4;
                            });
                          },
                          selected: ips[5] == 4,
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
                          title: 'Less than 2 years',
                          callback: (){
                            setState(() {
                              ips[6] = 1;
                            });
                          },
                          selected: ips[6] == 1,
                        ),
                        SelectorWidget(
                          top: 20,
                          title: '2 - 5 years',
                          callback: (){
                            setState(() {
                              ips[6] = 2;
                            });
                          },
                          selected: ips[6] == 2,
                        ),
                        SelectorWidget(
                          top: 20,
                          title: '6 - 10 years',
                          callback: (){
                            setState(() {
                              ips[6] = 3;
                            });
                          },
                          selected: ips[6] == 3,
                        ),
                        SelectorWidget(
                          top: 20,
                          title: '11 years or more',
                          callback: (){
                            setState(() {
                              ips[6] = 4;
                            });
                          },
                          selected: ips[6] == 4,
                        ),
                      ],),),
                  ],
                ),
              ),
            ),
            YMargin(50),
            RoundedNextButton(
              loading: loading,
              onTap:ips[currentPage] != -1 ? () async{
                if(currentPage == 6){
                  setState(() {
                    loading = true;
                  });
                  var result = await settingsViewModel.profileInvestor(
                    token: identityViewModel.user.token,
                    firstName: identityViewModel.user.fullname.split(" ").last,
                    lastName: identityViewModel.user.fullname.split(" ").first,
                    durationToCompletelyWithdraw: ips[6],
                    investmentDurationBeforeWithdrawal: ips[5],
                    mostConernedDuringInvestment: ips[1],
                    investmentKnowledge:ips[0],
                    instrumentCurrentlyOwned: ips[2],
                    email:locator<ABSStateLocalStorage>().getSecondaryState().email,
                    ethicalConsideration: false,
                    hypotheticalInvestmentPlan: ips[4],
                    marketAndParticularStockDrops: ips[3],
                  );
                  setState(() {
                    loading = false;
                  });
                  if(result.error == false){
                    Navigator.push(context, ResultSentScreen.route());
                    return;
                  }else{
                    showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
                      return PasswordSuccessWidget(onDone: (){
                        Navigator.pop(context);
                      },message: result?.errorMessage?? "An Error Occured",
                        success: false,);
                    }, isDismissible: false);
                    return;
                  }

                }

                setState(() {
                  currentPage = currentPage +1;
                });
                controller.animateToPage(currentPage,
                    duration: Duration(milliseconds: 300),curve: Curves.easeIn);
              }:null,
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
    Key key, this.selected, this.title, this.top = 32, this.height = 50, this.callback,
  }) : super(key: key);

  final bool selected;
  final String title;
  final double top;
  final double height;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
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
