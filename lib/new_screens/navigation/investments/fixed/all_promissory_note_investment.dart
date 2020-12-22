import 'package:flutter/material.dart';
import 'package:zimvest/data/models/investment/fixed_models.dart';
import 'package:zimvest/new_screens/navigation/investments/fixed/fixed_income_details.dart';
import 'package:zimvest/new_screens/navigation/investments/widgets/card_widget.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/strings.dart';

class AllPromissoryNoteBonds extends StatefulWidget {
  final String title;
  final List<PromissoryNoteItems> bondItem;

  static Route<dynamic> route(
      {String title, List<PromissoryNoteItems> bondItem}) {
    return MaterialPageRoute(
      builder: (_) => AllPromissoryNoteBonds(
        title: title,
        bondItem: bondItem,
      ),
      settings: RouteSettings(
        name: AllPromissoryNoteBonds().toStringShort(),
      ),
    );
  }

  const AllPromissoryNoteBonds({Key key, this.title, this.bondItem})
      : super(key: key);
  @override
  _AllPromissoryNoteBondsState createState() => _AllPromissoryNoteBondsState();
}

class _AllPromissoryNoteBondsState extends State<AllPromissoryNoteBonds> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kWhite,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.kPrimaryColor,
            ),
            onPressed: () => Navigator.pop(context)),
        title: Text(
          "Zimvest High Yield Dollar ${widget.title}",
          style: TextStyle(
              fontSize: 13,
              fontFamily: AppStrings.fontMedium,
              color: AppColors.kTextColor),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        children: widget.bondItem
            .where((element) => element.tenorBandName == widget.title)
            .toList()[0]
            .promissoryNotes
            .map(
              (e) => GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  FixedIncomeDetails.route(
                    bondName: e.promissoryNoteName,
                    id: e.instrumentId,
                    maturityDate: e.investmentMaturityDate,
                    rate: e.rate.toString(),
                  ),
                ),
                child: FixedIncomeCard(
                  bondName: e.promissoryNoteName,
                  maturityDate: e.investmentMaturityDate,
                  minimumAmount: e.minimumAmount,
                  rate: e.rate,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
