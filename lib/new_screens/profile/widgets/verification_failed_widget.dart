import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterwave/flutterwave.dart';
import 'package:flutterwave/models/responses/charge_response.dart';
import 'package:provider/provider.dart';
import 'package:rave_flutter/rave_flutter.dart';
import 'package:zimvest/data/models/payment/card.dart';
import 'package:zimvest/data/models/payment/card_payload.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/data/view_models/savings_view_model.dart';
import 'package:zimvest/new_screens/navigation/wealth/create/savings_summary.dart';
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

class SelectCardWidget extends StatefulWidget {
  const SelectCardWidget({
    Key key, this.success = true, this.navigate,
  }) : super(key: key);

  final bool success;
  final VoidCallback navigate;

  @override
  _SelectCardWidgetState createState() => _SelectCardWidgetState();
}

class _SelectCardWidgetState extends State<SelectCardWidget> {

  ABSPaymentViewModel paymentViewModel;
  ABSIdentityViewModel identityViewModel;
  ABSSavingViewModel savingViewModel;

  CardPayload cardPayload;

  @override
  Widget build(BuildContext context) {
    paymentViewModel = Provider.of(context);
    savingViewModel = Provider.of(context);
    identityViewModel = Provider.of(context);
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
                ...List.generate(paymentViewModel.userCards.length, (index) => CardItemWidget(
                  card: paymentViewModel.userCards[index],navigate: widget.navigate,)),

                Spacer(),
                Center(
                  child: PrimaryButtonNew(
                    onTap: (){
                      //Navigator.pop(context);
                      processTransaction();
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

  processTransaction() async {
    EasyLoading.show(status: "Initializing transaction");
    var result = await paymentViewModel.registerNewCard(identityViewModel.user.token);

    if(result.error == false){
      EasyLoading.showSuccess("Success");
      setState(() {
        cardPayload = result.data;
      });

      Flutterwave flutterwave = Flutterwave.forUIPayment(
          context: this.context,
          encryptionKey: cardPayload.encKey,
          publicKey: cardPayload.pbfPubKey,
          currency: "NGN",
          amount: "100",
          email: cardPayload.customerEmail,
          fullName: identityViewModel.user.fullname,
          txRef: cardPayload.txref,
          isDebugMode: false,
          phoneNumber: cardPayload.customerPhone,
          acceptCardPayment: true,
          acceptUSSDPayment: true,
          acceptAccountPayment: false,
          acceptFrancophoneMobileMoney: false,
          acceptGhanaPayment: false,
          acceptMpesaPayment: false,
          acceptRwandaMoneyPayment: true,
          acceptUgandaPayment: false,
          acceptZambiaPayment: false);


      // Initialize and get the transaction result
      try {
        print("ppppmmmm i want to");
        final ChargeResponse response = await flutterwave.initializeForUiPayments();
        if (response == null) {
          // user didn't complete the transaction. Payment wasn't successful.
        } else {
          final isSuccessful = checkPaymentIsSuccessful(response);
          if (isSuccessful) {
            EasyLoading.show(status: "Loading");
            var result = await paymentViewModel.paymentConfirmation(identityViewModel.user.token,
                cardPayload.txref
            );
            if(result.error == false){
              EasyLoading.showSuccess("Card Added");
            }else{
              EasyLoading.showError("Error occured");
            }
          } else {
            // check message
            print(response.message);
            EasyLoading.showError("Error occured");

            // check status
            print(response.status);

            // check processor error
            print(response.data.processorResponse);
          }
        }
      } catch (error, stacktrace) {
        EasyLoading.showError("Error occured");
        // handleError(error);
        print(error.toString());
      }
    }

    }

  processTransaction2() async {
    EasyLoading.show(status: "Initializing transaction");
    var result = await paymentViewModel.registerNewCard(identityViewModel.user.token);

    if(result.error == false){
      EasyLoading.showSuccess("Success");
      setState(() {
        cardPayload = result.data;
      });
      var initializer = RavePayInitializer(
          amount: 100, publicKey: cardPayload.pbfPubKey,
          encryptionKey: cardPayload.encKey)
        ..country = "NG"
        ..currency = "NGN"
        ..email = cardPayload.customerEmail
        ..fName = cardPayload.customerFirstname
        ..lName = cardPayload.customerLastname
        ..narration ="Add card"?? ''
        ..txRef = cardPayload.txref

        ..acceptCardPayments = true
        ..staging = true
        ..isPreAuth = false
        ..displayFee = true;

      // Initialize and get the transaction result
      RaveResult response = await RavePayManager()
          .prompt(context: context, initializer: initializer);
      print("response ${response.rawResponse}");
      if(response.status == RaveStatus.success){
        EasyLoading.show(status: "Loading");
        var result = await paymentViewModel.paymentConfirmation(identityViewModel.user.token,
            cardPayload.txref
        );
        if(result.error == false){
          await paymentViewModel.getUserCards(identityViewModel.user.token);
          EasyLoading.showSuccess("Card Added");
          Navigator.pop(context);
        }else{
          EasyLoading.showError("Error occured");
        }

      }else{
        EasyLoading.showError("Error occured");
      }
    }


  }


  bool checkPaymentIsSuccessful(final ChargeResponse response) {
    return response.data.status == FlutterwaveConstants.SUCCESSFUL &&
        response.data.currency == "NGN" &&
        response.data.amount == savingViewModel.amountToSave.toString() &&
        response.data.txRef == cardPayload.txref;
  }
}

class CardItemWidget extends StatelessWidget {
  const CardItemWidget({
    Key key, this.card, this.navigate,
  }) : super(key: key);

  final PaymentCard card;
  final VoidCallback navigate;

  @override
  Widget build(BuildContext context) {
    ABSPaymentViewModel paymentViewModel = Provider.of(context);
    ABSSavingViewModel savingViewModel = Provider.of(context);
    return GestureDetector(
      onTap: (){
        // savingViewModel.selectedChannel = savingViewModel
        //     .fundingChannels.firstWhere((element) => element.name == "Wallet");
        paymentViewModel.selectedCard = card;
        if(navigate == null){
          Navigator.of(context).pushReplacement(SavingsSummaryScreen.route());
        }else{
          navigate();
        }

      },
      child: Container(
        margin: EdgeInsets.only(top: 10),
        height: 60,
        child: Row(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Card ending with ${card.mp}", style: TextStyle(fontSize: 12),),
              YMargin(14),
              Text("Expires ${card.expiryDate}", style: TextStyle(fontSize: 10),),
            ],
          ),
          Spacer(),
          SvgPicture.asset('images/mastercard.svg')
        ],),
      ),
    );
  }
}