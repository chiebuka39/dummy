import 'package:flutter/material.dart';
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

class _NewCardScreenState extends State<NewCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ZimAppBar(title: "Add a new card",),
      body: Column(children: [
        TextWidgetBorder(title: "Card Number",),
        TextWidgetBorder(title: "Expiry date",),
        TextWidgetBorder(title: "cvv",),
        PrimaryButton(
          title: "Add Card",
          onPressed: (){},
        )
      ],),
    );
  }
}
