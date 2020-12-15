import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/widgets/buttons.dart';

class EnterPhoneWidget extends StatefulWidget {
  const EnterPhoneWidget({
    Key key, this.onNext,
  }) : super(key: key);
  final Function onNext;

  @override
  _EnterPhoneWidgetState createState() => _EnterPhoneWidgetState();
}

class _EnterPhoneWidgetState extends State<EnterPhoneWidget> {
  String phoneNumber = "";

  bool autoValidate = false;

  bool loading = false;
  ABSIdentityViewModel _identityViewModel;
  @override
  Widget build(BuildContext context) {
    _identityViewModel = Provider.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YMargin(50),
            Text("Enter Your Phone Number"),
            YMargin(30),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.kLightText,
                  borderRadius: BorderRadius.circular(12)
              ),
              child: TextField(
                onChanged: (value){
                  setState(() {
                    phoneNumber = value;
                  });
                  print("ooo ${phoneNumber.length}");
                },
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Phone Number",
                    hintStyle: TextStyle(
                        fontSize: 14
                    )
                ),
              ),
            ),
            if (autoValidate == false ? false :
            (phoneNumber.length != 10 && phoneNumber.length != 11)) Padding(
              padding: const EdgeInsets.only(left: 5,top: 5),
              child: Text("Phone number is incomplete", style: TextStyle(fontSize: 11,color: AppColors.kRed),),
            ) else SizedBox(),
           YMargin(100),
            RoundedNextButton(
              loading: loading,
              onTap: () async{
                if(loading){
                  return;
                }
                setState(() {
                  autoValidate = true;
                });
                if(phoneNumber.length > 11 || phoneNumber.length < 10){
                  return;
                }
                setState(() {
                  loading = true;
                });
                var result = await _identityViewModel.phoneAvailability(phoneNumber);
                setState(() {
                  loading = false;
                });
                if(result.error == true){

                  AppUtils.showError(context,title: 'Phone Number unavailable',
                      message: "The Phone Number you entered has already been taken, try another one");
                  print("login failed");
                  //widget.onNext(phoneNumber);
                }else{
                  if(result.data == false){
                    AppUtils.showError(context,title: 'Phone Number unavailable',
                        message: "The Phone Number you entered has already been taken, try another one");

                  }else{
                    widget.onNext(phoneNumber);
                  }
                  print("success");
                  //Navigator.of(context).pushReplacement(TabsContainer.route());
                }
                //
              },
            ),
            YMargin(120)
          ],),
      ),
    );
  }
}