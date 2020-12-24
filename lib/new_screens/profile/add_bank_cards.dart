import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/models/payment/bank.dart';
import 'package:zimvest/data/models/payment/card.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/new_screens/withdrawals/add_bank_account.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';

class AddBankAndCards extends StatefulWidget {

  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => AddBankAndCards(),
        settings:
        RouteSettings(name: AddBankAndCards().toStringShort()));
  }

  @override
  _AddBankAndCardsState createState() => _AddBankAndCardsState();
}

class _AddBankAndCardsState extends State<AddBankAndCards> with AfterLayoutMixin<AddBankAndCards> {

  ABSIdentityViewModel identityViewModel;
  ABSPaymentViewModel paymentViewModel;

  @override
  void afterFirstLayout(BuildContext context) {
    paymentViewModel.getCustomerBank(identityViewModel.user.token);
    paymentViewModel.getUserCards(identityViewModel.user.token);
  }

  @override
  Widget build(BuildContext context) {
    paymentViewModel = Provider.of(context);
    identityViewModel = Provider.of(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.kPrimaryColor),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined,size: 20,),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.transparent,
          title: Text("Banks & Cards",
            style: TextStyle(color: Colors.black87,
                fontSize: 13,
                fontFamily: AppStrings.fontMedium),),
          bottom: TabBar(
            indicatorColor: AppColors.kPrimaryColor,
            labelColor: AppColors.kPrimaryColor,
              unselectedLabelColor: AppColors.kGreyText,
              tabs: const <Widget>[
                Tab( text: "Banks",),
                Tab(text: "Cards",),
              ]),
        ),
        body: TabBarView(
          children: [
            BankWidget(),
            CardWidget(),
          ],
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ABSPaymentViewModel paymentViewModel = Provider.of(context);
    return paymentViewModel.userCards == null ? Container(
      child: Center(child: CupertinoActivityIndicator(),),
    ):paymentViewModel.userCards.isEmpty ?  Container(
      child: Column(children: [
        Spacer(flex: 2,),
        SvgPicture.asset("images/new/Addd1.svg"),
        YMargin(20),
        Text("Add your Debit Card", style: TextStyle(fontSize: 13,
            fontFamily: AppStrings.fontMedium,
            color: AppColors.kPrimaryColor),),

        Spacer(flex: 3,),
      ],),
    ):Container(
      child: Column(children: [
        ...List.generate(paymentViewModel.userCards.length, (index) {
          PaymentCard card = paymentViewModel.userCards[index];
          return Container(
            margin: EdgeInsets.only(left: 20, right: 20,top: 20),
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: 159,
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColors.kWhite,
                boxShadow: AppUtils.getBoxShaddowBank,
                borderRadius: BorderRadius.circular(9)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Spacer(),
                    Transform.translate(
                      offset: Offset(10,0),
                      child: IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.more_horiz_rounded,color: AppColors.kPrimaryColor,),
                      ),
                    ),
                  ],
                ),
                YMargin(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("xxxx",style: TextStyle(fontSize: 14,
                        fontFamily: AppStrings.fontMedium),),
                    Text("xxxx",style: TextStyle(fontSize: 14,
                        fontFamily: AppStrings.fontMedium),),
                    Text("xxxx",style: TextStyle(fontSize: 14,
                        fontFamily: AppStrings.fontMedium),),
                    Text(card.mp,style: TextStyle(fontSize: 14,
                        fontFamily: AppStrings.fontMedium),),
                  ],
                ),
                YMargin(30),
                Row(
                  children: [
                    Text(card.expiryDate, style: TextStyle(fontSize: 11,
                        fontFamily: AppStrings.fontNormal),),
                    Spacer(),
                    SvgPicture.asset('images/new/master.svg')
                  ],
                ),
              ],),
          );
        }),
        Spacer(),
        PrimaryButtonNew(
          title: "Add Debit Card",
        ),
        YMargin(30),
      ],),
    );
  }
}

class BankWidget extends StatelessWidget {
  const BankWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ABSPaymentViewModel paymentViewModel = Provider.of(context);
    return paymentViewModel.userBanks == null ? Container(
      child: Center(child: CupertinoActivityIndicator(),),
    ): paymentViewModel.userBanks.isEmpty ?Container(
      child: Column(children: [
        Spacer(flex: 2,),
        GestureDetector(
          onTap: (){
            Navigator.push(context, AddBankAccScreen.route());
          },
            child: SvgPicture.asset("images/new/Addd1.svg")),
        YMargin(20),
        Text("Add your Bank Account", style: TextStyle(fontSize: 13,
            fontFamily: AppStrings.fontMedium,
            color: AppColors.kPrimaryColor),),
        Spacer(flex: 3,),
      ],),
    ): Container(
      child: Column(children: [
        ...List.generate(paymentViewModel.userBanks.length, (index) {
          Bank bank = paymentViewModel.userBanks[index];
          return Container(
            margin: EdgeInsets.only(left: 20, right: 20,top: 20),
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: 159,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.kWhite,
              boxShadow: AppUtils.getBoxShaddowBank,
              borderRadius: BorderRadius.circular(9)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Row(
                children: [
                  Spacer(),
                  Transform.translate(
                    offset: Offset(10,0),
                    child: IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.more_horiz_rounded,color: AppColors.kPrimaryColor,),
                    ),
                  ),
                ],
              ),
                YMargin(20),
              Text(bank.accountName,style: TextStyle(fontSize: 14,
                  fontFamily: AppStrings.fontMedium),),
              YMargin(30),
              Row(
                children: [
                  Text(bank.accountNum, style: TextStyle(fontSize: 11,
                      fontFamily: AppStrings.fontNormal),),
                  Spacer(),
                  Text(bank.name,style: TextStyle(fontSize: 11,
                      fontFamily: AppStrings.fontNormal),),
                ],
              ),
            ],),
          );
        }),
        Spacer(),
        PrimaryButtonNew(
          title: "Add Bank Account",
        ),
        YMargin(30),
      ],),
    );
  }
}
