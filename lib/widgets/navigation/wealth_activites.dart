import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zimvest/data/models/product_transaction.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/navigation/wealthbox_activity.dart';

class WealthBoxActivities extends StatelessWidget {
  const WealthBoxActivities({
    Key key, this.transactions,
  }) : super(key: key);

  final List<ProductTransaction> transactions;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 50,
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
          child: ListView(

            children: [
              YMargin(20),
              Row(
                children: [
                  IconButton(icon: Icon(Icons.close), onPressed: (){
                      Navigator.of(context).pop();
                  }),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text("Activities", style: TextStyle(fontSize: 16,
                    fontFamily: AppStrings.fontBold, color: AppColors.kGreyText),),
              ),
              ...List.generate(transactions.length, (index) {
                return WealthBoxActivity(productTransaction: transactions[index],);
              })
            ],),
        ))
      ],),
    );
  }
}