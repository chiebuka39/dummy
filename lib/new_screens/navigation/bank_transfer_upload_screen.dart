import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/animations/loading.dart';
import 'package:zimvest/data/models/payment/bank.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/data/view_models/savings_view_model.dart';
import 'package:zimvest/data/view_models/wallets_view_model.dart';
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
import 'package:zimvest/widgets/new/anim.dart';

class UploadSummaryScreen extends StatefulWidget {
  final Bank bank;
  final File file;

  const UploadSummaryScreen({Key key, this.bank, this.file}) : super(key: key);
  static Route<dynamic> route({Bank bank, File file}) {
    return MaterialPageRoute(
        builder: (_) => UploadSummaryScreen(bank: bank,file: file,),
        settings:
        RouteSettings(name: UploadSummaryScreen().toStringShort()));
  }
  @override
  _UploadSummaryScreenState createState() => _UploadSummaryScreenState();
}
enum AniProps {   opacity1,offset1, scale }
class _UploadSummaryScreenState extends State<UploadSummaryScreen> with AfterLayoutMixin<UploadSummaryScreen>{

  List<GlobalKey<ItemFaderState>> keys;

  ABSSavingViewModel savingViewModel;
  ABSIdentityViewModel identityViewModel;
  ABSPaymentViewModel paymentViewModel;
  WalletViewModel walletViewModel;
  bool loading = false;

  final _tween = MultiTween<AniProps>()
    ..add(AniProps.offset1, Tween(begin: Offset(0, 10), end: Offset(0, 0)),
        800.milliseconds, Interval(0.0, 1.0, curve: Curves.easeIn,))
    ..add(AniProps.scale, Tween(begin: 0.0, end: 1.0),
        800.milliseconds, Interval(0.0, 0.6, curve: Curves.bounceInOut,))
    ..add(AniProps.opacity1, 0.0.tweenTo(1.0),
        800.milliseconds, Interval(0.0, 1.0, curve: Curves.ease,));

  bool confirmed = false;

  bool error = false;

  String errorMessage = "Error Occured";

  @override
  void initState() {
    keys = List.generate(2, (index) => GlobalKey<ItemFaderState>());
    //Future.delayed(1000.milliseconds).then((value) => onInit());
    super.initState();
  }




  Future makeRemoteCall() async {
    setState(() {

      loading = true;
    });
    var result = await walletViewModel.fundWalletTransfer(
        file: widget.file,
        bank: widget.bank
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
        loading = false;
        error = true;
        errorMessage = result.errorMessage;

      });
    }
  }

  void onInit() async {
    for (var key in keys) {
      //await Future.delayed(Duration(seconds: 1));
      key.currentState.show();
    }

  }

  @override
  void afterFirstLayout(BuildContext context) {
    makeRemoteCall();
  }


  @override
  Widget build(BuildContext context) {
    identityViewModel = Provider.of(context);
    savingViewModel = Provider.of(context);
    paymentViewModel = Provider.of(context);
    walletViewModel = Provider.of(context);
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
            SvgPicture.asset("images/patterns.svg", fit: BoxFit.fill,),
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
                              child: Text(errorMessage.isEmpty ? "Your Wealth box creation was successful":errorMessage, style: TextStyle(color: Colors.white, fontFamily: AppStrings.fontNormal),)),
                          Spacer(),
                          ItemFader(
                            offset: 10,
                            curve: Curves.easeIn,
                            key: keys[1],
                            child: PrimaryButtonNew(
                              onTap: (){
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (context) => TabsContainer()),
                                        (Route<dynamic> route) => false);
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
                    child: Text(errorMessage,
                      style: TextStyle(color: AppColors.kWhite,
                          fontFamily: AppStrings.fontNormal,height: 1.7),textAlign: TextAlign.center,)),
                Spacer(),
                PrimaryButtonNew(
                  title: "Back to Home",
                  onTap: (){

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => TabsContainer()),
                            (Route<dynamic> route) => false);
                    Future.delayed(Duration(seconds: 1)).then((value) {
                      savingViewModel.startDate = null;
                      savingViewModel.selectedChannel = null;
                      savingViewModel.amountToSave = 0.0;
                      savingViewModel.autoSave = null;
                      savingViewModel.selectedFrequency = null;
                    });
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
  DateTime getDate(){
    DateTime now = DateTime.now();
    List<DateTime> quaters = [DateTime(now.year,1),DateTime(now.year,4),
      DateTime(now.year,7),DateTime(now.year,10)];
    print(",,,,,,,,ooooo ${quaters.where((element) => element.microsecondsSinceEpoch >= now.microsecondsSinceEpoch)}");
    return quaters.where((element) => element.microsecondsSinceEpoch >= now.microsecondsSinceEpoch).first;
  }
}
