import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/animations/select_dialog.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/settings_view_model.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

class ResidentialScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => ResidentialScreen(),
        settings:
        RouteSettings(name: ResidentialScreen().toStringShort()));
  }
  @override
  _ResidentialScreenState createState() => _ResidentialScreenState();
}

class _ResidentialScreenState extends State<ResidentialScreen> {
  String _state = "";
  String _residentialAddress = "";

  ABSSettingsViewModel settingsViewModel;
  ABSIdentityViewModel identityViewModel;

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    settingsViewModel = Provider.of(context);
    identityViewModel = Provider.of(context);
    return Scaffold(
      appBar: ZimAppBar(
        text: 'Residential Address',
        icon: Icons.arrow_back_ios,
        callback: (){
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          YMargin(35),
          Text("Residential Address".toUpperCase(), style: TextStyle(
            fontSize: 11,fontFamily: AppStrings.fontNormal
          ),),
          YMargin(15),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.kGreyBg,
              borderRadius: BorderRadius.circular(12)
            ),
            child: TextField(
              onChanged: (value){
                setState(() {
                  _residentialAddress = value;
                });
              },
              maxLines: 3,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter Residential Address',

              ),
            ),
          ),
            YMargin(35),
            Text("State of residence".toUpperCase(), style: TextStyle(
                fontSize: 11,fontFamily: AppStrings.fontNormal
            ),),
            YMargin(15),
            GestureDetector(
              onTap: (){
                SelectDialog.showModal<String>(
                  context,
                  label: "State of residence",
                  constraints: BoxConstraints(
                      maxHeight: 350,
                      maxWidth: MediaQuery.of(context).size.width * 0.7
                  ),
                  titleStyle: TextStyle(color: Colors.brown),
                  showSearchBox: false,
                  selectedValue: _state,
                  backgroundColor: Colors.white,
                  items: AppUtils.states,
                  onChange: (String selected) {
                    setState(() {
                      _state = selected;
                    });
                  },
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.kGreyBg,
                    borderRadius: BorderRadius.circular(12)
                ),
                child: Row(children: [
                  Text(_state.isEmpty ?"Choose State" : _state, style: TextStyle(
                    fontSize: 14, fontFamily: AppStrings.fontNormal
                  ),),
                  Spacer(),
                  Icon(Icons.arrow_drop_down)
                ],),
              ),
            ),
            YMargin(76),
            Center(
              child: PrimaryButtonNew(
                loading: loading,
                title: "Submit",
                onTap: _residentialAddress.isEmpty || _state.isEmpty ? null: ()async{
                  setState(() {
                    loading = true;
                  });
                  var result = await settingsViewModel.updateResidentialAddress(
                    token: identityViewModel.user.token,
                    address: _residentialAddress,
                    state: AppUtils.states.indexOf(_state)+ 1
                  );
                  setState(() {
                    loading = false;
                  });
                  if(result.error == false){
                    showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
                      return PasswordSuccessWidget(onDone: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },message: "Your Residential address was added successfully",);
                    });
                  }else{
                    showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
                      return PasswordSuccessWidget(onDone: (){

                        Navigator.pop(context);
                      },message: result.errorMessage == null ? "We could not update your residential address": result.errorMessage,);
                    });
                  }
                },
              ),
            )
        ],),
      ),
    );
  }
}
