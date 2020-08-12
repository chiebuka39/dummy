import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rave_flutter/rave_flutter.dart';
import 'package:zimvest/data/models/payment/card_payload.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/payment/input_formaters.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/widgets/account_widgets.dart';
import 'package:zimvest/widgets/appbars.dart';
import 'package:zimvest/widgets/buttons.dart';

class NewCardScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => NewCardScreen(),
        settings: RouteSettings(name: NewCardScreen().toStringShort()));
  }
  @override
  _NewCardScreenState createState() => _NewCardScreenState();
}

class _NewCardScreenState extends State<NewCardScreen> with AfterLayoutMixin<NewCardScreen> {
  ABSPaymentViewModel paymentViewModel;
  ABSIdentityViewModel identityViewModel;
  CardPayload cardPayload;

  String cardNumber;
  String expDate;
  String cvv;
  @override
  void afterFirstLayout(BuildContext context) async{
    var result = await paymentViewModel.registerNewCard(identityViewModel.user.token);
    if(result.error == false){
      setState(() {
        cardPayload = result.data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    paymentViewModel = Provider.of(context);
    identityViewModel = Provider.of(context);
    return Scaffold(
      appBar: ZimAppBar(title: "Add a new card",),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(children: [
            YMargin(20),
            CardWidgetBorder(title: "Card Number",
              textColor: AppColors.kAccountTextColor,inputFormaters: [
                WhitelistingTextInputFormatter.digitsOnly,
                new LengthLimitingTextInputFormatter(19),
                new CardNumberInputFormatter()
              ],
              onChange: (value){
                cardNumber = value;
                print("value $cardNumber");
              },
              keyboardType: TextInputType.number,),
            CardWidgetBorder(title: "Expiry date",
              textColor: AppColors.kAccountTextColor,
              inputFormaters: [
                WhitelistingTextInputFormatter.digitsOnly,
                new LengthLimitingTextInputFormatter(4),
                new CardMonthInputFormatter()
              ],
              onChange: (value){
                expDate = value;
                print("value $expDate");
              },
              keyboardType: TextInputType.number,
            ),
            CardWidgetBorder(title: "cvv",
              textColor: AppColors.kAccountTextColor,
              keyboardType: TextInputType.number,inputFormaters: [
                WhitelistingTextInputFormatter.digitsOnly,
                new LengthLimitingTextInputFormatter(4),
              ],
            onChange: (value){
              cvv = value;
              print("cvv $cvv");
            },
            ),
            YMargin(20),
            PrimaryButton(
              title: "Add Card",
              onPressed: processTransaction,
            )
          ],),
        ),
      ),
    );
  }
  processTransaction() async {
    // Get a reference to RavePayInitializer
    var initializer = RavePayInitializer(
        amount: 500, publicKey: "FLWPUBK_TEST-0b9b992382ff9c21794196be85bb49ad-X",
        encryptionKey: "FLWSECK_TEST8dc18f6e5200")
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
  }
}
