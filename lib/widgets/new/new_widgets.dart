import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
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
          Text("${AppStrings.nairaSymbol} ${paymentViewModel.wallet.where((element) => element.currency == "NGN").first.balance}", style: TextStyle(color: AppColors.kWhite,
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
                child: Center(child: SvgPicture.asset("images/icon_face.svg"),),
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
                onTap: (){},
                title: "Yes",
                width: 200,
              ),
              YMargin(10),
              FlatButton(onPressed: (){}, child: Text("No",
                style: TextStyle(fontFamily: AppStrings.fontNormal),)),
              Spacer(),
            ],),
        ))
      ],),
    );
  }
}
class PasswordSuccessWidget extends StatelessWidget {
  const PasswordSuccessWidget({
    Key key, this.message ="Your password was changed succesfully ", this.onDone,
  }) : super(key: key);

  final String message;
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
              Center(child: SvgPicture.asset("images/new/success.svg"),),
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