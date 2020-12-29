import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';

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