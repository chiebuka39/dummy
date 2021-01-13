import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/settings_view_model.dart';
import 'package:zimvest/new_screens/investor_profile/investor_profile_form.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

class InvestorProfileScreen extends StatefulWidget {

  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => InvestorProfileScreen(),
        settings:
        RouteSettings(name: InvestorProfileScreen().toStringShort()));
  }

  @override
  _InvestorProfileScreenState createState() => _InvestorProfileScreenState();
}

class _InvestorProfileScreenState extends State<InvestorProfileScreen> with AfterLayoutMixin<InvestorProfileScreen> {
  ABSSettingsViewModel settingsViewModel;
  ABSIdentityViewModel identityViewModel;
  bool isCompleted;

  @override
  void afterFirstLayout(BuildContext context)async {
   var result =await settingsViewModel.checkipsstatus(
       token: identityViewModel.user.token);
   if(result.error == false){
     setState(() {
       isCompleted = result.data;
     });
   }

  }

  @override
  Widget build(BuildContext context) {
    identityViewModel = Provider.of(context);
    settingsViewModel = Provider.of(context);
    return Scaffold(
      appBar: ZimAppBar(
        text: "Investor Profile",
        callback: (){
          Navigator.pop(context);
        },
        icon: Icons.clear,
      ),
      body: Column(children: [
        YMargin(30),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.all( 20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.kWhite,
              borderRadius: BorderRadius.circular(17),
              boxShadow: AppUtils.getBoxShaddow3
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text("Investment Persona Analysis",
                style: TextStyle(fontSize: 15, fontFamily: AppStrings.fontBold),),
                YMargin(20),
                Text(AppStrings.ips, style: TextStyle(fontSize: 11,
                    fontFamily: AppStrings.fontLight,height: 1.8),)
            ],),

          ),
        ),
        YMargin(50),
        PrimaryButtonNew(
          onTap: (){
            Navigator.push(context, InvestorProfileForm.route());
          },
          title: 'Get Started',
        ),
        YMargin(30),
      ],),
    );
  }
}
