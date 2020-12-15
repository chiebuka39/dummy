import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/payment/input_formaters.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/widgets/buttons.dart';

class EnterDOBWidget extends StatefulWidget {
  const EnterDOBWidget({
    Key key, this.onNext,
  }) : super(key: key);

  final Function onNext;

  @override
  _EnterDOBWidgetState createState() => _EnterDOBWidgetState();
}

class _EnterDOBWidgetState extends State<EnterDOBWidget> {
  TextEditingController controller = TextEditingController();

  String dob;
  DateTime dobb;
  bool loading = true;

  ABSIdentityViewModel identityViewModel;
  @override
  Widget build(BuildContext context) {
    identityViewModel = Provider.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YMargin(50),
          Text("Enter Your Date of Birth"),
          YMargin(30),
          GestureDetector(
            onTap: ()async{
              DateTime time =await  showDatePicker(context: context,
                  initialDate: DateTime(2000), firstDate: DateTime(1920), lastDate: DateTime(2005));
              if(time != null){
                setState(() {
                  dobb = time;
                  dob = "${AppUtils.addLeadingZeroIfNeeded(time.month)}"
                      "/${AppUtils.addLeadingZeroIfNeeded(time.day)}/${time.year}";
                });

              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 60,
              alignment: Alignment.centerLeft,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.kLightText,
                  borderRadius: BorderRadius.circular(12)
              ),
              child: Text(dob == null ?"MM/DD/YYYY": dob),
            ),
          ),
          Spacer(),
          RoundedNextButton(
            onTap: ()async{
              if(dob.length != 10){

               return;
              }
              setState(() {
                loading = true;
              });
              var result = await identityViewModel.sendEmailOTP(identityViewModel.email);
              setState(() {
                loading = false;
              });
              if(result.error == true){

                AppUtils.showError(context,title: 'Something went wrong',
                    message: "Please try again, to complete your request");
                print("login failed");
                //widget.onNext(phoneNumber);
              }else{

                  widget.onNext(dobb);

                print("success");
                //Navigator.of(context).pushReplacement(TabsContainer.route());
              }
            },
          ),
          YMargin(120)
        ],),
    );
  }
}