import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/pin_view_model.dart';
import 'package:zimvest/data/view_models/savings_view_model.dart';
import 'package:zimvest/new_screens/navigation/wealth/aspire/choose_start_screen.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/new/keyboard_widget.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

class SavingsTargetScreen extends StatefulWidget {
  const SavingsTargetScreen({
    Key key,
  }) : super(key: key);
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => SavingsTargetScreen(),
        settings:
        RouteSettings(name: SavingsTargetScreen().toStringShort()));
  }

  @override
  _SavingsTargetScreenState createState() => _SavingsTargetScreenState();
}

class _SavingsTargetScreenState extends State<SavingsTargetScreen> {

  ABSSavingViewModel savingViewModel;


  @override
  Widget build(BuildContext context) {
    savingViewModel = Provider.of(context);
    ABSPinViewModel pinViewModel = Provider.of(context);
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: ZimAppBar(
          showCancel: true,
          callback: (){
          Navigator.pop(context);
          pinViewModel.resetAmount();
        },icon: Icons.arrow_back_ios_outlined,text: "Create Zimvest Aspire",),
        body: GestureDetector(
          onTap: (){
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YMargin(40),
                Text("Set a target amount for this goal ?", style: TextStyle(fontSize: 15,
                    color: AppColors.kGreyText,
                    fontFamily: AppStrings.fontBold),),
                YMargin(12),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.kGreyBg,
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                      child: Text(pinViewModel.amount.convertWithComma(), style: TextStyle(fontSize: 15),)),
                ),
                YMargin(10),
                SizedBox(
                  width: 300,
                  child: Text("You can always top up your savings anytime "
                      "once you create this savings plan", style: TextStyle(
                      fontSize: 10,height: 1.6),),
                ),
                YMargin(height < 650 ? 25:height > 700 ? 70:40),


                RoundedNextButton(
                  onTap:pinViewModel.amount.isEmpty ? null : double.parse(pinViewModel.amount) > 1000 ? (){
                    savingViewModel.amountToSave = double.parse(pinViewModel.amount);
                    Navigator.push(context, ChooseStartScreen.route());
                    pinViewModel.resetAmount();
                  }:null,
                ),
                YMargin(height < 650 ? 25:height > 700 ? 65:40),
                NumKeyboardWidget(

                )



              ],),
          ),
        ),
      ),
    );
  }


}