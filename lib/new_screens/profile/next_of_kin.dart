import 'package:flutter/material.dart';
import 'package:zimvest/new_screens/profile/widgets/verification_failed_widget.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';

class NextOfKinScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => NextOfKinScreen(),
        settings:
        RouteSettings(name: NextOfKinScreen().toStringShort()));
  }
  @override
  _NextOfKinScreenState createState() => _NextOfKinScreenState();
}

class _NextOfKinScreenState extends State<NextOfKinScreen> {
  String _selectedGender;

  DateTime _dob;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color:AppColors.kTextColor),
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(icon: Icon(Icons.close, color: AppColors.kPrimaryColor,), onPressed: () {
            Navigator.pop(context);
          },),
        ),
        title: Text("Next of kin", style: TextStyle(fontSize: 13,
            fontFamily: AppStrings.fontMedium,color: AppColors.kTextColor),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            YMargin(40),
            Text("full name".toUpperCase(), style: TextStyle(fontSize: 11),),
            YMargin(15),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.kGreyBg,
                  borderRadius: BorderRadius.circular(12)
              ),
              child: Transform.translate(
                offset: Offset(0,5),
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Full Name",
                      hintStyle: TextStyle(
                          fontSize: 14
                      )
                  ),
                ),
              ),
            ),
            YMargin(25),
            Text("Email Address".toUpperCase(), style: TextStyle(fontSize: 11),),
            YMargin(15),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.kGreyBg,
                  borderRadius: BorderRadius.circular(12)
              ),
              child: Transform.translate(
                offset: Offset(0,5),
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Email Address",
                      hintStyle: TextStyle(
                          fontSize: 14
                      )
                  ),
                ),
              ),
            ),
            YMargin(25),
            Text("Phone Number".toUpperCase(), style: TextStyle(fontSize: 11),),
            YMargin(15),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.kGreyBg,
                  borderRadius: BorderRadius.circular(12)
              ),
              child: Transform.translate(
                offset: Offset(0,5),
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Phone Number",
                      hintStyle: TextStyle(
                          fontSize: 14
                      )
                  ),
                ),
              ),
            ),
            YMargin(25),
            Text("Gender".toUpperCase(), style: TextStyle(fontSize: 11),),
            YMargin(15),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.kGreyBg,
                  borderRadius: BorderRadius.circular(12)
              ),
              child: DropdownButtonHideUnderline(
                child: new DropdownButton<String>(
                  value: _selectedGender,
                  isDense: true,
                  hint: Text('Choose a Gender', style: TextStyle(fontSize: 13),),
                  onChanged: (String newValue) {
                    setState(() => _selectedGender = newValue);

                  },
                  items: ['Male',"Female"]
                      .map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  })
                      .cast<DropdownMenuItem<String>>()
                      .toList(),
                ),
              ),
            ),
            YMargin(25),
            Text("Relationship".toUpperCase(), style: TextStyle(fontSize: 11),),
            YMargin(15),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.kGreyBg,
                    borderRadius: BorderRadius.circular(12)
                ),
                child: DropdownButtonHideUnderline(
                  child: new DropdownButton<String>(
                    value: _selectedGender,
                    isDense: true,
                    hint: Text('What’s your relationship', style: TextStyle(fontSize: 13),),
                    onChanged: (String newValue) {
                      setState(() => _selectedGender = newValue);

                    },
                    items: ['Father',"Mother", 'Sister',"Brother"]
                        .map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    })
                        .cast<DropdownMenuItem<String>>()
                        .toList(),
                  ),
                ),
              ),
              YMargin(58),
              Center(
                child: PrimaryButtonNew(
                  title: "Save",
                  onTap: (){
                    showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
                      return NextOfKinStatus(success: false,);
                    });
                  },
                ),
              ),
              YMargin(58),

          ],),
        ),
      ),
    );
  }
}
