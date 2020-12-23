import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/validator.dart';
import 'package:zimvest/widgets/buttons.dart';

import '../../../utils/strings.dart';
import '../../../utils/strings.dart';
import '../../../widgets/buttons.dart';

class ChangeMailWidget extends StatefulWidget {
  const ChangeMailWidget({
    Key key, 
  }) : super(key: key);


  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => ChangeMailWidget(),
        settings:
        RouteSettings(name: ChangeMailWidget().toStringShort()));
  }

  @override
  _EnterMailWidgetState createState() => _EnterMailWidgetState();
}

class _EnterMailWidgetState extends State<ChangeMailWidget> {
  String _email = "";

  bool _emailError = false;
  bool loading = false;

  bool autoValidate = false;
  ABSIdentityViewModel _identityViewModel;

  final FocusNode _nodeText1 = FocusNode();
  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
       
    
        KeyboardActionsItem(
          focusNode: _nodeText1,
          toolbarButtons: [
           
                (node) {
              return FlatButton(
                onPressed: () => node.unfocus(),
                child: Text(
                  "DONE",
                  style: TextStyle(color: Colors.black),
                ),
              );
            }
          ],
        ),
   
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    _identityViewModel = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.kPrimaryColor),
        leading: IconButton(
          icon: Icon(Icons.clear,size: 20,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        title: Text("Change Email Address ",
          style: TextStyle(color: Colors.black87,fontSize: 14, fontFamily: AppStrings.fontMedium),),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YMargin(50),
              Text("Enter new Email", style: TextStyle(fontFamily: AppStrings.fontMedium),),
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
                  focusNode: _nodeText1,
                  onChanged: (value){
                    if (EmailValidator.validate(value)) {
                      _emailError = false;
                    } else {
                      _emailError = true;
                    }
                    _email = value;
                    setState(() {});
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Email Address",
                      hintStyle: TextStyle(
                          fontSize: 14
                      )
                  ),
                ),
              ),
              if (autoValidate == false ? false : _emailError) Padding(
                padding: const EdgeInsets.only(left: 5,top: 5),
                child: Text("Email is incorrect", style: TextStyle(fontSize: 11,color: AppColors.kRed),),
              ) else SizedBox(),
             YMargin(100),
              Center(
                child: PrimaryButtonNew(
                  title: "Change Email Address",
                  loading: loading,
                  onTap: loading? null: () async{
                    setState(() {
                      autoValidate = true;
                    });
                    if(_emailError || _email.isEmpty){
                      return;
                    }
                    setState(() {
                      loading = true;
                    });
                    var result = await _identityViewModel.emailAvailability(_email);
                    setState(() {
                      loading = false;
                    });
                    if(result.error == true){

                      AppUtils.showError(context,title: 'Email unavailable',
                          message: "The email you entered has already been taken, try another one");
                      print("login failed");
                    }else{
                      if(result.data == false){
                        AppUtils.showError(context,title: 'Email unavailable',
                            message: "The email you entered has already been taken, try another one");
                      }else{
                        _identityViewModel.email = _email;
                        Navigator.pop(context);
                      }
                      print("success");
                      //Navigator.of(context).pushReplacement(TabsContainer.route());
                    }
                    //
                  }
                ),
              ),
              YMargin(120)
            ],),
        ),
      ),
    );
  }
}