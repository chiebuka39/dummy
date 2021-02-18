import 'package:flutter/material.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/widgets/buttons.dart';

class ChooseGenderWidget extends StatefulWidget {
  const ChooseGenderWidget({
    Key key, this.onNext,
  }) : super(key: key);
  final Function onNext;

  @override
  _ChooseGenderWidgetState createState() => _ChooseGenderWidgetState();
}

class _ChooseGenderWidgetState extends State<ChooseGenderWidget> {
  String gender = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YMargin(50),
            Text("Choose Your Gender"),
            YMargin(30),
            Row(children: [
              GestureDetector(
                onTap: (){
                  setState(() {
                    gender = 'male';
                  });
                },
                child: SelectGenderWidget(emoji: "male",title: "Male",gender: gender,),
              ),
              Spacer(),
              GestureDetector(
                onTap: (){
                  setState(() {
                    gender = 'female';
                  });
                },
                child:SelectGenderWidget(emoji:"fem",title: "Female",gender: gender,),
              ),
            ],),
            YMargin(50),
            RoundedNextButton(
              onTap: (){
                if(gender != null){
                  widget.onNext(gender);
                }
              },
            ),
            YMargin(120)
          ],),
      ),
    );
  }
}

class SelectGenderWidget extends StatelessWidget {
  const SelectGenderWidget({
    Key key, this.title, this.emoji, this.gender,
  }) : super(key: key);
  final String title;
  final String emoji;
  final String gender;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: 135,
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: gender == title.toLowerCase() ?
        AppColors.kPrimaryColor:Colors.transparent, width: gender == title.toLowerCase() ? 1.6:0),
        color: gender == title.toLowerCase() ? AppColors.kPrimaryColor.withOpacity(0.38): AppColors.kGreyBg
      ),
      child: Center(child: Column(

        children: [
          Spacer(flex: 2,),
        Image.asset("images/$emoji.png"),
        YMargin(5),
        Text(title),
          Spacer(flex: 3,),
      ],),),
    );
  }
}