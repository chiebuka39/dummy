import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';

class NextOfKinStatus extends StatelessWidget {
  const NextOfKinStatus({
    Key key, this.success = true,
  }) : super(key: key);

  final bool success;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(children: [
        YMargin(10),
        Center(child: Container(
          width: 30,
          height: 5,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5)
          ),
        ),),
        YMargin(20),
        Expanded(child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25)
              )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              YMargin(40),
              Center(child: SvgPicture.asset("images/new/${success ? 'success':'fail'}.svg"),),
              YMargin(27),
              SizedBox(
                width: 230,
                child: Text("${success ? 'Your Next of Kin Was Saved Successfully':'Your Next of Kin Was update failed'}", style: TextStyle(
                    fontFamily: AppStrings.fontMedium,height: 1.7
                ),textAlign: TextAlign.center,),
              ),
             
              Spacer(),
              PrimaryButtonNew(
                onTap: (){
                  Navigator.pop(context);
                },
                title: "Done",
                width: 200,
              ),

              Spacer(),
            ],),
        ))
      ],),
    );
  }
}

class SelectCardWidget extends StatelessWidget {
  const SelectCardWidget({
    Key key, this.success = true,
  }) : super(key: key);

  final bool success;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(children: [
        YMargin(10),
        Center(child: Container(
          width: 30,
          height: 5,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5)
          ),
        ),),
        YMargin(20),
        Expanded(child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25)
              )
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YMargin(40),
                Text("Select Card", style: TextStyle(fontSize: 15, fontFamily: AppStrings.fontBold),),
                YMargin(27),
                ...List.generate(2, (index) => CardItemWidget()),

                Spacer(),
                Center(
                  child: PrimaryButtonNew(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    title: "Add New Card",
                    width: 200,
                  ),
                ),

                Spacer(),
              ],),
          ),
        ))
      ],),
    );
  }
}

class CardItemWidget extends StatelessWidget {
  const CardItemWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 60,
      child: Row(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Card ending with 8976", style: TextStyle(fontSize: 12),),
            YMargin(14),
            Text("Expires 08/2021", style: TextStyle(fontSize: 10),),
          ],
        ),
        Spacer(),
        SvgPicture.asset('images/mastercard.svg')
      ],),
    );
  }
}