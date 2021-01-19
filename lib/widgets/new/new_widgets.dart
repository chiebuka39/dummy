import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/local/user_local.dart';
import 'package:zimvest/data/models/secondary_state.dart';
import 'package:zimvest/data/services/connectivity_service.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/locator.dart';
import 'package:zimvest/new_screens/profile/verif_code_screen.dart';
import 'package:zimvest/new_screens/tabs.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';

class SelectWallet extends StatelessWidget {
  const SelectWallet({
    Key key,@required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    ABSPaymentViewModel paymentViewModel = Provider.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
            color: AppColors.kSecondaryColor,
            borderRadius: BorderRadius.circular(15)
        ),
        child: Row(children: [
          SvgPicture.asset("images/new/wallet1.svg"),
          XMargin(10),
          Text("Wallet", style: TextStyle(color: AppColors.kWhite,
              fontSize: 13,fontFamily: AppStrings.fontNormal),),
          Spacer(),
          Text(AppStrings.nairaSymbol, style: TextStyle(fontSize: 12, color: AppColors.kWhite),),
          Text(" ${paymentViewModel.wallet == null ? '0.0':paymentViewModel.wallet.where((element) => element.currency == "NGN").first.balance}", style: TextStyle(color: AppColors.kWhite,
              fontSize: 13,fontFamily: AppStrings.fontNormal),),
          XMargin(5),
          Icon(Icons.navigate_next_rounded,color: AppColors.kWhite,)
        ],),
      ),
    );
  }
}


class DollarWallet extends StatelessWidget {
  const DollarWallet({
    Key key,@required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    ABSPaymentViewModel paymentViewModel = Provider.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
            color: AppColors.kSecondaryColor,
            borderRadius: BorderRadius.circular(15)
        ),
        child: Row(children: [
          SvgPicture.asset("images/new/wallet1.svg"),
          XMargin(10),
          Text("Wallet", style: TextStyle(color: AppColors.kWhite,
              fontSize: 13,fontFamily: AppStrings.fontNormal),),
          Spacer(),
          Text("${AppStrings.dollarSymbol} ${paymentViewModel.wallet.where((element) => element.currency == "USD").first.balance}", style: TextStyle(color: AppColors.kWhite,
              fontSize: 13,fontFamily: AppStrings.fontNormal),),
          XMargin(5),
          Icon(Icons.navigate_next_rounded,color: AppColors.kWhite,)
        ],),
      ),
    );
  }
}

class ZimAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ZimAppBar({
    Key key, this.icon = Icons.clear,@required this.callback, this.text = "Top Up",
  }) : super(key: key);

  final IconData icon;
  final String text;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black87),
      leading: IconButton(
        icon: Icon(icon,size: 20,color: AppColors.kPrimaryColor,),
        onPressed: callback,
      ),
      backgroundColor: Colors.transparent,
      title: Text(text,
        style: TextStyle(color: Colors.black87,fontSize: 14,fontFamily: AppStrings.fontMedium),),
    );
  }

  @override

  Size get preferredSize => Size.fromHeight(56.0);
}

class PasswordCheck extends StatelessWidget {
  const PasswordCheck({
    Key key, this.title, this.flex = 2,
  }) : super(key: key);
  final String title;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
          height: 22,
          decoration: BoxDecoration(
              color: AppColors.kFixed.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12)
          ),
          child: Row(
            children: [
              SvgPicture.asset("images/new/p_check.svg"),
              XMargin(5),
              Text(title, style: TextStyle(fontSize: 9),),
            ],
          )),
    );
  }
}

class PasswordError extends StatelessWidget {
  const PasswordError({
    Key key, this.title, this.flex = 2,
  }) : super(key: key);
  final String title;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
          height: 22,
          decoration: BoxDecoration(
              color: AppColors.kWealth.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12)
          ),
          child: Row(
            children: [
              SvgPicture.asset("images/new/p_error.svg"),
              XMargin(5),
              Text(title, style: TextStyle(fontSize: 9),),
            ],
          )),
    );
  }
}

class EnableFaceIdWidget extends StatelessWidget {
  const EnableFaceIdWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(children: [
        YMargin(10),
        Center(child: Container(
          width: 30,
          height: 5,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5)
          ),
        ),),
        YMargin(20),
        Expanded(child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25)
              )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              YMargin(40),
              Container(
                height: 65,
                width: 63,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17),
                    color: AppColors.kGrey
                ),
                child: Center(child: SvgPicture.asset("images/new/face_id.svg"),),
              ),
              YMargin(27),
              Text("Enable Face ID", style: TextStyle(
                  fontFamily: AppStrings.fontMedium
              ),),
              YMargin(26),
              SizedBox(
                width: 250,
                child: Text("Enable Face ID for easier authentication,"
                    "you can turn this off in the setting ", style: TextStyle(
                    fontFamily: AppStrings.fontNormal,
                    height: 1.7,
                    fontSize: 11,color: AppColors.kGreyText
                ),textAlign: TextAlign.center,),
              ),
              Spacer(),
              PrimaryButtonNew(
                onTap: (){
                  locator<ABSStateLocalStorage>().saveSecondaryState(SecondaryState.updateBiometrics(true,
                      locator<ABSStateLocalStorage>().getSecondaryState()));
                  EasyLoading.showSuccess('Pin Created');
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => TabsContainer()),
                          (Route<dynamic> route) => false);
                },
                title: "Yes",
                width: 200,
              ),
              YMargin(10),
              FlatButton(onPressed: (){
                locator<ABSStateLocalStorage>().saveSecondaryState(SecondaryState.updateBiometrics(false,
                    locator<ABSStateLocalStorage>().getSecondaryState()));
                EasyLoading.showSuccess('Pin Created');
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => TabsContainer()),
                        (Route<dynamic> route) => false);
              }, child: Text("No",
                style: TextStyle(fontFamily: AppStrings.fontNormal),)),
              Spacer(),
            ],),
        ))
      ],),
    );
  }
}
class ResetPinWidget extends StatelessWidget {
  const ResetPinWidget({
    Key key,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(children: [
        YMargin(10),
        Center(child: Container(
          width: 30,
          height: 5,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5)
          ),
        ),),
        YMargin(20),
        Expanded(child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25)
              )
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YMargin(40),
                Text("Reset Zimvest Pin?", style: TextStyle(
                    fontFamily: AppStrings.fontBold,
                    fontSize: 15,color: AppColors.kGreyText,
                ),textAlign: TextAlign.start,),
                YMargin(20),
                SizedBox(
                  width: 250,
                  child: Text('No problem, we’ll send you a mail with an '
                      'OTP to reset your pin ',style: TextStyle(
                    fontSize: 12, fontFamily: AppStrings.fontNormal,height: 1.7
                  ),),
                ),
                Spacer(),
                Center(
                  child: PrimaryButtonNew(
                    onTap: (){
                      Navigator.pop(context);
                      Navigator.push(context, VerifCodeScreen.route());
                    },
                    title: "Reset Pin",
                    width: 200,
                  ),
                ),
                Spacer(),
              ],),
          ),
        ))
      ],),
    );
  }
}
class PasswordSuccessWidget extends StatelessWidget {
  const PasswordSuccessWidget({
    Key key, this.message ="Your password was changed succesfully ",
    this.onDone, this.success = true,
  }) : super(key: key);

  final String message;
  final bool success;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(children: [
        YMargin(10),
        Center(child: Container(
          width: 30,
          height: 5,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5)
          ),
        ),),
        YMargin(20),
        Expanded(child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25)
              )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              YMargin(40),
           Center(child: SvgPicture.asset(  "images/new/${success == true ? 'success':'not_success'}.svg"),),
              YMargin(27),
              SizedBox(
                width: 250,
                child: Text(message, style: TextStyle(
                    fontFamily: AppStrings.fontMedium,
                    height: 1.7,
                    fontSize: 14,color: AppColors.kGreyText
                ),textAlign: TextAlign.center,),
              ),
              Spacer(),
              PrimaryButtonNew(
                onTap: onDone,
                title: "Done",
                width: 200,
              ),
              Spacer(),
            ],),
        ))
      ],),
    );
  }
}
class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({
    Key key, this.message ="",
    this.onDone, this.success = true,
  }) : super(key: key);

  final String message;
  final bool success;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    ConnectionProvider connectionProvider = Provider.of(context);

    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(children: [
        YMargin(10),
        Center(child: Container(
          width: 30,
          height: 5,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5)
          ),
        ),),
        YMargin(20),
        Expanded(child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25)
              )
          ),
          child: Column(
            children: [
              YMargin(30),
              SvgPicture.asset("images/new/error3.svg"),
              YMargin(20),
              SizedBox(
                  width: 300,
                  child: Text('Failed to connect, please connect to the internet and try again',style:TextStyle(fontFamily: AppStrings.fontNormal,height: 1.7),textAlign: TextAlign.center,)),
              YMargin(30),
              PrimaryButtonNew(
                title: 'Okay',
                onTap: (){
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ))
      ],),
    );

  }
}

class ImageUploadWidget extends StatelessWidget {
  const ImageUploadWidget({
    Key key, this.title ="Upload Utility bill", this.onCamera,
    this.onGallery,
  }) : super(key: key);

  final String title;
  final VoidCallback onCamera;
  final VoidCallback onGallery;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(children: [
        YMargin(10),
        Center(child: Container(
          width: 30,
          height: 5,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5)
          ),
        ),),
        YMargin(20),
        Expanded(child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25)
              )
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YMargin(40),
                Text("Upload Utility Bill", style: TextStyle(fontSize: 15,
                    fontFamily: AppStrings.fontBold),),
                YMargin(37),
                InkWell(
                  onTap: onCamera,
                  child: Container(
                    height: 60,
                    child: Row(children: [
                      SvgPicture.asset("images/new/photo1.svg"),
                      XMargin(10),
                      Text("Take Photo"),
                      Spacer(),
                      Icon(Icons.navigate_next,color: AppColors.kPrimaryColor,)
                    ],),
                  ),
                ),
                InkWell(
                  onTap: onGallery,
                  child: Container(
                    height: 60,
                    child: Row(children: [
                      SvgPicture.asset("images/new/library.svg"),
                      XMargin(10),
                      Text("Choose from Library"),
                      Spacer(),
                      Icon(Icons.navigate_next,color: AppColors.kPrimaryColor,)
                    ],),
                  ),
                ),
              ],),
          ),
        ))
      ],),
    );
  }
}

class SecuritySwitchWidget extends StatelessWidget {

  final bool status;
  final String title;

  final Function toggle;

  const SecuritySwitchWidget({Key key, this.status,
    this.toggle, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        toggle(!status);
      },
      child: Container(height: 60,
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Text(title, style: TextStyle(fontSize: 13,
                fontFamily: AppStrings.fontNormal),),
            Spacer(),
            FlutterSwitch(
              width: 40.0,
              height: 22.0,
              toggleSize: 15.0,
              value: status,
              borderRadius: 30.0,

              padding: 2.0,
              activeToggleColor: AppColors.kWhite,
              inactiveToggleColor: AppColors.kPrimaryColor,
              activeSwitchBorder: Border.all(
                color: Color(0xFF3C1E70),
                width: 0.0,
              ),
              inactiveSwitchBorder: Border.all(
                color: Color(0xFFD1D5DA),
                width: 0.0,
              ),
              activeColor: AppColors.kPrimaryColor,
              inactiveColor: AppColors.kGrey,
              activeIcon: Icon(
                Icons.check,
                color: AppColors.kPrimaryColor,
                size: 11,
              ),
              inactiveIcon: Icon(
                Icons.clear,
                color: Colors.white,
                size: 11,
              ),
              onToggle: (val) {
                toggle(val);
              },
            ),
          ],
        ),
      ),
    );
  }
}


