import 'package:flutter/material.dart';
import 'package:zimvest/screens/account/login_screen.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  PageController pageController = PageController();

  @override
  void initState() {
    pageController.addListener(() {
      setState(() {
        currentIndex = pageController.page.floor();
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            children: [
              OnboardingWidget(desc: "A chance to live on your own terms",image: "onboarding_1",),
              OnboardingWidget(desc: "Getting it right for your family from the start",image: "onboarding_2"),
              OnboardingWidget(desc: "A retirment without worries",image: "onboarding_3"),
            ],
          ),
          Positioned(
            bottom: 150,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(children: [
                OnboardingIndicatorWidget(color: currentIndex == 0 ? AppColors.kAccentColor:AppColors.kWhite,),
                XMargin(8),
                OnboardingIndicatorWidget(color: currentIndex == 1 ? AppColors.kAccentColor:AppColors.kWhite),
                XMargin(8),
                OnboardingIndicatorWidget(color: currentIndex == 2 ? AppColors.kAccentColor:AppColors.kWhite)
              ],),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              children: [
                Visibility(
                  visible: currentIndex > 0,
                  child: FlatButton(

                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.navigate_before, size: 27,color: Colors.white,),
                        Text("Previous", style: TextStyle(color: Colors.white, fontFamily: "Caros-Medium"),),

                      ],),onPressed: (){},
                  ),
                ),
                Spacer(),
                FlatButton(

                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text( currentIndex == 2? "Continue":"Next", style: TextStyle(color: Colors.white, fontFamily: "Caros-Medium"),),
                      Icon(Icons.navigate_next, size: 27,color: Colors.white,)
                    ],),onPressed: (){
                    Navigator.of(context).pushReplacement(LoginScreen.route());
                },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingWidget extends StatelessWidget {
  final String image;
  final String title;
  final String desc;

  const OnboardingWidget({
    Key key, this.image, this.title = "What does investment mean to you", this.desc,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      child: Stack(
        children: [
          Image.asset("images/$image.png",
            height: MediaQuery.of(context).size.height,fit: BoxFit.cover,),
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0,0.9,1.0],
                    colors: [Color(0x00000000),
                      Color(0xaf000000),
                      Color(0xcd000000),
                    ])
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Align(
                alignment: Alignment.centerRight,
                child: FlatButton(child: Text("Skip", style: TextStyle(color: AppColors.kWhite,
                    fontFamily: "Caros-Medium"),),onPressed: (){},),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: SizedBox(
                  width: 280,
                  child: Text(title,
                    style: TextStyle(fontFamily: "Caros-Bold", color: Colors.white, fontSize: 25),),
                ),
              ),
              YMargin(25),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: SizedBox(
                  width: 280,
                  child: Text(desc,
                    style: TextStyle(fontFamily: "Caros-Medium", color: Colors.white, fontSize: 12),),
                ),
              ),
                YMargin(191),

            ],),
          )
        ],
      ),
    );
  }
}

class OnboardingIndicatorWidget extends StatelessWidget {
  final Color color;
  const OnboardingIndicatorWidget({
    Key key, this.color =AppColors.kWhite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 4,
      width: 50,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5)
      ),
    );
  }
}
