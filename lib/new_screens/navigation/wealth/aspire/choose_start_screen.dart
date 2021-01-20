import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/savings_view_model.dart';
import 'package:zimvest/new_screens/navigation/wealth/aspire/choose_due_screen.dart';
import 'package:zimvest/new_screens/navigation/wealth/create/choose_funding_source.dart';

import 'package:zimvest/payment/input_formaters.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/navigation/checkBox.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

class ChooseStartScreen extends StatefulWidget {
  const ChooseStartScreen({
    Key key,
  }) : super(key: key);
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => ChooseStartScreen(),
        settings:
        RouteSettings(name: ChooseStartScreen().toStringShort()));
  }

  @override
  _ChooseStartScreenState createState() => _ChooseStartScreenState();
}

class _ChooseStartScreenState extends State<ChooseStartScreen> with AfterLayoutMixin<ChooseStartScreen> {

  DateTime _time;
  DateTime _selectedTime;

  bool today = false;

  ABSSavingViewModel savingViewModel;
  ABSIdentityViewModel identityViewModel;

  @override
  void afterFirstLayout(BuildContext context) async{

    await savingViewModel.getSavingFrequency(token:identityViewModel.user.token);
    await savingViewModel.getFundingChannel(token:identityViewModel.user.token);
  }


  @override
  Widget build(BuildContext context) {
    savingViewModel = Provider.of(context);
    identityViewModel = Provider.of(context);

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: ZimAppBar(
          showCancel: true,
          callback: (){
          Navigator.pop(context);
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
                Text("Start Date", style: TextStyle(fontSize: 15,
                    color: AppColors.kGreyText,
                    fontFamily: AppStrings.fontBold),),
                YMargin(12),
                InkWell(
                  onTap: (){
                    setState(() {
                      _time = DateTime.now();
                      _selectedTime = null;
                      today = true;
                    });
                  },
                  child: Container(
                    height: 50,
                    child: Row(
                      children: [
                        Text("I’ll start today", style: TextStyle(fontSize: 13),),
                        Spacer(),
                        AnimatedSwitcher(
                            duration: Duration(milliseconds: 600),
                            child: today == true ?check: checkEmpty)
                      ],
                    ),
                  ),
                ),
                YMargin(20),
                GestureDetector(
                  onTap: ()async{
                    DateTime time = await showDatePicker(context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2025));
                    if(time != null){
                      setState(() {
                        _time = time;
                        _selectedTime = time;
                        today = false;
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColors.kGreyBg,
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Row(
                      children: [
                        Text(_selectedTime == null ? "Set preferred Date":
                        "${_selectedTime.year}/${AppUtils.addLeadingZeroIfNeeded(_time.month)}/${AppUtils.addLeadingZeroIfNeeded(_time.day)}", style: TextStyle(fontSize: 12,
                            color: AppColors.kTextColor.withOpacity(0.53)),),
                        Spacer(),
                        Icon(Icons.keyboard_arrow_down_rounded)
                      ],
                    ),
                  ),
                ),
                YMargin(70),


                RoundedNextButton(
                  onTap:_time == null ? null: (){
                    savingViewModel.startDate = _time;
                    Navigator.push(context, ChooseDuedateScreen.route());
                  },
                ),
                YMargin(65),




              ],),
          ),
        ),
      ),
    );
  }

  convertWithComma(String newValue){
    String value = newValue;
    var buffer = new StringBuffer();

    if(value.length == 4){
      buffer.write(value[0]);
      buffer.write(',');
      buffer.write(value[1]);
      buffer.write(value[2]);
      buffer.write(value[3]);
    }else if(value.length == 5){
      buffer.write(value[0]);
      buffer.write(value[1]);
      buffer.write(',');
      buffer.write(value[2]);
      buffer.write(value[3]);
      buffer.write(value[4]);
    }else if(value.length == 6){
      buffer.write(value[0]);
      buffer.write(value[1]);
      buffer.write(value[2]);
      buffer.write(',');
      buffer.write(value[3]);
      buffer.write(value[4]);
      buffer.write(value[5]);
    }else if(value.length == 7){
      buffer.write(value[0]);
      buffer.write(',');
      buffer.write(value[1]);
      buffer.write(value[2]);
      buffer.write(value[3]);
      buffer.write(',');
      buffer.write(value[4]);
      buffer.write(value[5]);
      buffer.write(value[6]);
    }else if(value.length == 8){
      buffer.write(value[0]);
      buffer.write(value[1]);
      buffer.write(',');
      buffer.write(value[2]);
      buffer.write(value[3]);
      buffer.write(value[4]);
      buffer.write(',');
      buffer.write(value[5]);
      buffer.write(value[6]);
      buffer.write(value[7]);
    }else if(value.length == 9){
      buffer.write(value[0]);
      buffer.write(value[1]);
      buffer.write(value[2]);
      buffer.write(',');
      buffer.write(value[3]);
      buffer.write(value[4]);
      buffer.write(value[5]);
      buffer.write(',');
      buffer.write(value[6]);
      buffer.write(value[7]);
      buffer.write(value[8]);
    }
    else{
      for (int i = 0; i < value.length; i++) {
        print('lllllf $i');
        buffer.write(value[i]);
        var nonZeroIndex = i + 1;

        if (nonZeroIndex % 3 == 0 && nonZeroIndex != value.length) {
          buffer.write(',');
        }

      }
    }

    return buffer.toString();

  }
}