import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/animations/loading.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/data/view_models/savings_view_model.dart';
import 'package:zimvest/new_screens/funding/top_up_successful.dart';
import 'package:zimvest/new_screens/navigation/investments/widgets/terms_and_conditions_box.dart';
import 'package:zimvest/new_screens/tabs.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/navigation/delete_wealthbox.dart';

class SavingsSummaryScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => SavingsSummaryScreen(),
        settings:
        RouteSettings(name: SavingsSummaryScreen().toStringShort()));
  }
  @override
  _SavingsSummaryScreenState createState() => _SavingsSummaryScreenState();
}

class _SavingsSummaryScreenState extends State<SavingsSummaryScreen> {

  List<GlobalKey<ItemFaderState>> keys;

  ABSSavingViewModel savingViewModel;
  ABSIdentityViewModel identityViewModel;
  ABSPaymentViewModel paymentViewModel;
  bool loading = false;

  final _tween = MultiTween<AniProps>()
    ..add(AniProps.offset1, Tween(begin: Offset(0, 10), end: Offset(0, 0)),
        800.milliseconds, Interval(0.0, 1.0, curve: Curves.easeIn,))
    ..add(AniProps.scale, Tween(begin: 0.0, end: 1.0),
        800.milliseconds, Interval(0.0, 0.6, curve: Curves.bounceInOut,))
    ..add(AniProps.opacity1, 0.0.tweenTo(1.0),
        800.milliseconds, Interval(0.0, 1.0, curve: Curves.ease,));

  bool confirmed = false;

  bool slideUp = false;

  bool error = false;
  String errorMessage = "";

  @override
  void initState() {
    keys = List.generate(2, (index) => GlobalKey<ItemFaderState>());

    super.initState();
  }

  void startAnim(BuildContext buildContext)async{
    showModalBottomSheet<Null>(
        context: buildContext,
        builder: (BuildContext context) {
          return TermsAndConditionsbox(
            onTapNo: (){
              Navigator.pop(context);
              Navigator.pop(context);
            },onTapYes: ()async{
            Navigator.pop(context);
            await makeRemoteCall();
          },
          );
        },
        isScrollControlled: true);







  }

  Future makeRemoteCall() async {
    setState(() {
      slideUp = true;
      loading = true;
    });
    var result = await savingViewModel.createTargetSavings2(
    
        cardId:paymentViewModel.selectedCard?.id ?? null,
        token: identityViewModel.user.token,
        fundingChannel: paymentViewModel.selectedCard == null ?
        savingViewModel.fundingChannels.firstWhere((element) => element.name == "Wallet").id:
        savingViewModel.fundingChannels.firstWhere((element) => element.name == "Card").id,
        savingsAmount: getSavingsAmount()
    );
    print("ooooo ${result.error}");
    print("4444 ${result.errorMessage}");
    if(result.error == false){
      setState(() {
        loading = false;
        confirmed = true;
    
        if(result.errorMessage != null){
    
          errorMessage = result.errorMessage;
    
        }
    
      });
    
        Future.delayed(1000.milliseconds).then((value) => onInit());
    
    
    }else{
      setState(() {
        loading= false;
        error = true;
        errorMessage = result.errorMessage;
      });
      print(";;;;;;;; ${result.errorMessage}");
    }
  }

  void onInit() async {
    for (var key in keys) {
      //await Future.delayed(Duration(seconds: 1));
      key.currentState.show();
    }

  }


  @override
  Widget build(BuildContext context) {
    identityViewModel = Provider.of(context);
    savingViewModel = Provider.of(context);
    paymentViewModel = Provider.of(context);
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.kSecondaryColor,
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(children: [
            slideUp == false ? SizedBox():SvgPicture.asset("images/patterns.svg", fit: BoxFit.fill,),
            Positioned.fill(
              child: confirmed ? PlayAnimation<MultiTweenValues<AniProps>>(
                tween: _tween,
                duration: _tween.duration,
                builder: (context, child, value){
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Spacer(),
                          Transform.scale(
                              scale: value.get(AniProps.scale),
                              child: Transform.translate(
                                  offset: value.get(AniProps.offset1),
                                  child: Opacity(
                                      opacity: value.get(AniProps.opacity1),
                                      child: SvgPicture.asset("images/new/confetti.svg")))),
                          YMargin(40),
                          ItemFader(
                              offset: 10,
                              curve: Curves.easeIn,
                              key: keys[0],
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 30),
                                child: Text(errorMessage.isEmpty ? "Your Target creation was succesful":errorMessage, style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
                              )),
                          Spacer(),
                          ItemFader(
                            offset: 10,
                            curve: Curves.easeIn,
                            key: keys[1],
                            child: PrimaryButtonNew(
                              onTap: (){
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (context) => TabsContainer(tab: 2,)),
                                        (Route<dynamic> route) => false);
                                Future.delayed(Duration(seconds: 2)).then((value) {
                                  paymentViewModel.selectedCard = null;
                                  savingViewModel.startDate = null;
                                  savingViewModel.goalName = "";
                                  savingViewModel.selectedFrequency = null;
                                  savingViewModel.amountToSave = null;
                                  savingViewModel.selectedChannel = null;
                                });


                              },
                              textColor: Colors.white,
                              title: "Done",
                              bg: AppColors.kPrimaryColor,
                            ),
                          ),
                          YMargin(50)
                        ],),
                    ),
                  );
                },
              ):SizedBox(),
            ),

            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              //top: -(MediaQuery.of(context).size.height - 200),
              top: slideUp ?-containerHeight(size, context): 0,
              left: 0,right: 0,
              child: Container(
                width: double.infinity,
                height: containerHeight(size, context),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),

                  ),
                  boxShadow: AppUtils.getBoxShaddow3
                ),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: BackButton(
                          color: AppColors.kPrimaryColor,

                          onPressed: (){
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      YMargin(size.height < 650 ? 15:size.height > 700 ? 70:40),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text("Savings Summary", style: TextStyle(fontFamily: AppStrings.fontMedium),),
                      ),
                      YMargin(20),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 25),
                        height: size.height < 650 ? 320:size.height > 700 ? 380:340,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.kWhite,
                          boxShadow: AppUtils.getBoxShaddow3
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text("Plan name".toUpperCase(), style: TextStyle(fontSize: 12,
                              color: AppColors.kSecondaryText,fontFamily: AppStrings.fontNormal,),),
                            Spacer(),
                            Text(savingViewModel.goalName, style: TextStyle(
                                fontFamily: AppStrings.fontMedium,
                                fontSize: 13,color: AppColors.kGreyText
                            ),),
                            YMargin(size.height < 650 ? 20:size.height > 700 ? 40:30),
                            Row(children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Frequency".toUpperCase(), style: TextStyle(fontSize: 11,
                                    color: AppColors.kSecondaryText,fontFamily: AppStrings.fontNormal,),),
                                  YMargin(15),
                                  Text(savingViewModel.selectedFrequency.name, style: TextStyle(
                                      fontFamily: AppStrings.fontMedium,
                                      fontSize: 13,color: AppColors.kGreyText
                                  ),),
                                ],),
                              Spacer(),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("Interest rate".toUpperCase(), style: TextStyle(fontSize: 12,
                                    color: AppColors.kSecondaryText,fontFamily: AppStrings.fontNormal,),),
                                  YMargin(15),
                                  Text("6% P.A", style: TextStyle(
                                      fontFamily: AppStrings.fontMedium,
                                      fontSize: 13,color: AppColors.kGreyText
                                  ),),
                                ],),


                            ],),
                            YMargin(size.height < 650 ? 20:size.height > 700 ? 40:30),
                            Row(children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${savingViewModel.selectedFrequency.name} amount".toUpperCase(), style: TextStyle(fontSize: 12,
                                    color: AppColors.kSecondaryText,fontFamily: AppStrings.fontNormal,),),
                                  YMargin(15),
                                  Row(
                                    children: [
                                      Text(AppStrings.nairaSymbol),
                                      Text(getFrequencyAmount(), style: TextStyle(
                                          fontFamily: AppStrings.fontMedium,
                                          fontSize: 13,color: AppColors.kGreyText
                                      ),),
                                    ],
                                  ),
                              ],),
                              Spacer(),

                              Column(

                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("target amount".toUpperCase(), style: TextStyle(fontSize: 11,
                                    color: AppColors.kSecondaryText,fontFamily: AppStrings.fontNormal,),),
                                  YMargin(15),
                                  Row(
                                    children: [
                                      Text(AppStrings.nairaSymbol),
                                      Text(" ${getAmount(savingViewModel.amountToSave.toInt())}", style: TextStyle(
                                          fontFamily: AppStrings.fontMedium,
                                          fontSize: 13,color: AppColors.kGreyText
                                      ),),
                                    ],
                                  ),
                              ],)
                            ],),
                            YMargin(size.height < 650 ? 20:size.height > 700 ? 40:30),
                            Row(children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("start date".toUpperCase(), style: TextStyle(fontSize: 12,
                                    color: AppColors.kSecondaryText,fontFamily: AppStrings.fontNormal,),),
                                  YMargin(15),
                                  Text(AppUtils.getReadableDate2(savingViewModel.startDate), style: TextStyle(
                                      fontFamily: AppStrings.fontMedium,
                                      fontSize: 13,color: AppColors.kGreyText
                                  ),),
                              ],),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("Next maturity date".toUpperCase(), style: TextStyle(fontSize: 11,
                                    color: AppColors.kSecondaryText,fontFamily: AppStrings.fontNormal,),),
                                  YMargin(15),
                                  Text(AppUtils.getReadableDate2(savingViewModel.endDate), style: TextStyle(
                                      fontFamily: AppStrings.fontMedium,
                                      fontSize: 13,color: AppColors.kGreyText
                                  ),),
                              ],)
                            ],),
                            Spacer(),


                        ],),
                      )
                  ],),
                ),
              ),
            ),

            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              //top: MediaQuery.of(context).size.height - 100,
              top:slideUp == true ? -60: (MediaQuery.of(context).size.height - 100),
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: (){
                  // showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
                  //   return ConfirmSavings();
                  // },isScrollControlled: true);
                },
                onVerticalDragStart: (details){
                  print("dff ${details.toString()}");
                  startAnim(context);
                },
                child: Container(
                  height: 60,
                  child: Column(children: [
                    Column(
                      children: [
                        Icon(Icons.keyboard_arrow_up, color: AppColors.kWhite,),
                        Text("Swipe up to confirm", style: TextStyle(fontFamily: AppStrings.fontMedium,
                            color: Colors.white),),
                      ],
                    )
                  ],),
                ),
              ),
            ),
            error == false ? Container(
              height: size.height,
              width: size.width,
              child: Center(child: loading ? LoadingWIdget():SizedBox()
                ,),
            ):Container(
              height: size.height,
              width: size.width,
              child: Center(child:Column(children: [
                Spacer(),
                SvgPicture.asset("images/new/error2.svg"),
                YMargin(40),
                SizedBox(
                  width: 250,
                    child: Text(errorMessage == null ? "Error Occured": errorMessage.isEmpty ? "Error Occured": errorMessage, style: TextStyle(color: AppColors.kWhite, fontFamily: AppStrings.fontNormal,height: 1.7),
                      textAlign: TextAlign.center,)),
                Spacer(),
                PrimaryButtonNew(
                  title: "Back to Home",
                  onTap: (){
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => TabsContainer()),
                            (Route<dynamic> route) => false);
                  },
                ),
                YMargin(40)
              ],)
                ,),
            ),
          ],),
        ),
      ),
    );
  }

  double containerHeight(Size size, BuildContext context) => size.height < 650 ? MediaQuery.of(context).size.height * 0.8:size.height > 700 ? MediaQuery.of(context).size.height * 0.8:MediaQuery.of(context).size.height * 0.7;

  getFrequencyAmount() {
    if(savingViewModel.selectedFrequency.id == 2){
      return " ${getAmount(savingViewModel.amountToSave ~/
          (savingViewModel.endDate.difference(savingViewModel.startDate).inDays) )}";
    }else if(savingViewModel.selectedFrequency.id == 3){
      return " ${getAmount(savingViewModel.amountToSave ~/
          (savingViewModel.endDate.difference(savingViewModel.startDate).inDays) * 7 ) }";
    }
    else if(savingViewModel.selectedFrequency.id == 4){
      return " ${getAmount(savingViewModel.amountToSave ~/
          (savingViewModel.endDate.difference(savingViewModel.startDate).inDays) * 30 ) }";
    }
    else if(savingViewModel.selectedFrequency.id == 5){
      return " ${getAmount(savingViewModel.amountToSave ~/
          (savingViewModel.endDate.difference(savingViewModel.startDate).inDays) * 120 ) }";
    }
    else if(savingViewModel.selectedFrequency.id == 6){
      return " ${getAmount(savingViewModel.amountToSave ~/
          (savingViewModel.endDate.difference(savingViewModel.startDate).inDays) * 183 ) }";
    }
    return " ${getAmount(savingViewModel.amountToSave.toInt())}";
  }

  int getSavingsAmount(){
    if(savingViewModel.selectedFrequency.id == 2){
      return savingViewModel.amountToSave ~/
          (savingViewModel.endDate.difference(savingViewModel.startDate).inDays) ;
    }else if(savingViewModel.selectedFrequency.id == 3){
      return savingViewModel.amountToSave ~/
          (savingViewModel.endDate.difference(savingViewModel.startDate).inDays) * 7  ;
    }else if(savingViewModel.selectedFrequency.id == 4){
      return savingViewModel.amountToSave ~/
          (savingViewModel.endDate.difference(savingViewModel.startDate).inDays) * 30  ;
    }
    return savingViewModel.amountToSave.toInt();
  }

  String getAmount(int amount) {
    return amount.toString().convertWithComma();
  }
}
class ItemFader extends StatefulWidget {
  final Widget child;
  final Curve curve;
  final int offset;

  const ItemFader({Key key, this.child, this.curve = Curves.easeInOut, this.offset = 64}) : super(key: key);
  @override
  ItemFaderState createState() => ItemFaderState();
}

class ItemFaderState extends State<ItemFader>
    with SingleTickerProviderStateMixin {
  int position = 1;
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation =
        CurvedAnimation(parent: _animationController, curve: widget.curve);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return AnimatedBuilder(
      animation: _animation,
      child: widget.child,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, widget.offset * position * (1 - _animation.value)),
          child: Opacity(
            opacity: _animation.value,
            child: child,
          ),
        );
      },
    );
  }

  show() {
    setState(() {
      position = 1;
    });
    _animationController.forward();
  }

  hide() {
    setState(() {
      position = -1;
    });
    _animationController.reverse();
  }
}