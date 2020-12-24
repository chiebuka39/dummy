import 'package:flutter/material.dart';
import 'package:zimvest/data/models/investment/fixed_models.dart';
import 'package:zimvest/new_screens/navigation/investments/fixed/commercial_papers/fixed_income_details.dart';
import 'package:zimvest/new_screens/navigation/investments/widgets/card_widget.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/strings.dart';

class AllCommercialPaperBonds extends StatefulWidget {
  final String title;
  final List<ComercialPaperItems> bondItem;

  static Route<dynamic> route(
      {String title, List<ComercialPaperItems> bondItem}) {
    return MaterialPageRoute(
      builder: (_) => AllCommercialPaperBonds(
        title: title,
        bondItem: bondItem,
      ),
      settings: RouteSettings(
        name: AllCommercialPaperBonds().toStringShort(),
      ),
    );
  }

  const AllCommercialPaperBonds({Key key, this.title, this.bondItem})
      : super(key: key);
  @override
  _AllCommercialPaperBondsState createState() =>
      _AllCommercialPaperBondsState();
}

class _AllCommercialPaperBondsState extends State<AllCommercialPaperBonds> {
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
            .commercialPapers
            .map(
              (e) => GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  FixedIncomeDetails.route(
                    bondName: e.bondName,
                    id: e.instrumentId,
                    maturityDate: e.investmentMaturityDate,
                    rate: e.rate,
                    investmentType: e.investmentType,
                    instrumentId: e.instrumentId,
                    minimumAmount: e.minimumAmount,
                    investmentMaturityDate: e.investmentMaturityDate,
                  ),
                ),
                child: FixedIncomeCard(
                  bondName: e.bondName,
                  maturityDate: e.investmentMaturityDate,
                  minimumAmount: e.investmentType,
                  rate: e.rate,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
