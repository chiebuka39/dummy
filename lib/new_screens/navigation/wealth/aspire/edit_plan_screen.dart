import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/data/view_models/savings_view_model.dart';
import 'package:zimvest/new_screens/navigation/wealth/aspire/automate_screen.dart';
import 'package:zimvest/new_screens/navigation/wealth/aspire/choose_funding_source.dart';
import 'package:zimvest/new_screens/navigation/wealth/aspire/save_frequency.dart';
import 'package:zimvest/payment/input_formaters.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

class EditPlanScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => EditPlanScreen(),
        settings:
        RouteSettings(name: EditPlanScreen().toStringShort()));
  }
  @override
  _EditPlanScreenState createState() => _EditPlanScreenState();
}

class _EditPlanScreenState extends State<EditPlanScreen> {

  File _image;

  final picker = ImagePicker();

  ABSSavingViewModel savingViewModel;
  ABSIdentityViewModel identityViewModel;
  ABSPaymentViewModel paymentViewModel;

  String goalName;

  double savingsAmount;

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    savingViewModel = Provider.of(context);
    identityViewModel = Provider.of(context);
    paymentViewModel = Provider.of(context);
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: ZimAppBar(
        text: "Edit Goal",
        icon: Icons.clear,
        callback: (){
          Navigator.pop(context);
        },
      ),
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              YMargin(20),
              GestureDetector(
                onTap: (){
                  showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
                    return ImageUploadWidget(onCamera: (){
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },onGallery: (){
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },title: "Custom target image",);
                  }, isScrollControlled: true);
                },
                child: Container(
                  height: 154,
                  width: (width /2) - 20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10)),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: _image == null ? CachedNetworkImage(imageUrl: 'https://firebasestorage.googleapis.com/v0/b/tick-bc0e3.appspot.com/o/pexels-anete-lusina-5723322.'
                            'jpg?alt=media&token=4858ef91-820b-4ff3-aae7-a02ce3507c6d',
                          height: 154,fit: BoxFit.fill,):Image.file(_image,height: 154,fit: BoxFit.fill,width: (width /2) - 20,),
                      ),
                      Container(
                        height: 154,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black.withOpacity(0.4)
                        ),
                      ),
                      Center(
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: AppColors.kWhite,
                              shape: BoxShape.circle
                          ),
                          child: Center(child: SvgPicture.asset('images/cam.svg'),),
                        ),
                      ),



                    ],
                  ),
                ),
              ),
              YMargin(40),
              Text("Goal Name", style: TextStyle(fontSize: 15, fontFamily: AppStrings.fontBold),),
              YMargin(15),
              Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                height: 60,
                padding: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                    color: AppColors.kGreyBg,
                    borderRadius: BorderRadius.circular(12)
                ),
                child: TextFormField(
                  initialValue: savingViewModel.goalName,
                  onChanged: (value){
                    savingViewModel.goalName = value;
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none
                  ),
                ),
              ),
                YMargin(20),
                Text("Target amount for this goal", style: TextStyle(fontSize: 15, fontFamily: AppStrings.fontBold),),
                YMargin(15),
                Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  height: 60,
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                      color: AppColors.kGreyBg,
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,

                    initialValue: savingViewModel.amountToSave.toInt().toString(),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CurrencyPtBrInputFormatter(maxDigits: 11)
                    ],
                    onChanged: (value){
                      savingViewModel.amountToSave = double.parse(value.replaceAll(",", ""));
                    },
                    decoration: InputDecoration(
                      prefix: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Text(AppStrings.nairaSymbol, style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                        border: InputBorder.none
                    ),
                  ),
                ),
                YMargin(20),
                Text("How often will you like to save?", style: TextStyle(fontSize: 15, fontFamily: AppStrings.fontBold),),
                YMargin(15),
                InkWell(
                  onTap: (){
                    showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
                      return SavingsFrequencyWidget();
                    });
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    height: 60,
                    padding: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                        color: AppColors.kGreyBg,
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Row(children: [
                      Text(savingViewModel.selectedFrequency.name),
                      Spacer(),
                      Icon(Icons.keyboard_arrow_down_rounded, size: 30,),
                      XMargin(20)
                    ],),
                  ),
                ),
                YMargin(20),
                Text("Savings Automation", style: TextStyle(fontSize: 15, fontFamily: AppStrings.fontBold),),
                YMargin(15),
                InkWell(
                  onTap: (){
                    showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
                      return SavingsAutomationWidget();
                    });
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    height: 60,
                    padding: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                        color: AppColors.kGreyBg,
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Row(children: [
                      Text(savingViewModel.autoSave ? 'Yes debit me automatically':"No, I would save whenever I want"),
                      Spacer(),
                      Icon(Icons.keyboard_arrow_down_rounded, size: 30,),
                      XMargin(20)
                    ],),
                  ),
                ),
                YMargin(20),
                Text("Savings Amount", style: TextStyle(fontSize: 15, fontFamily: AppStrings.fontBold),),
                YMargin(15),
                Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  height: 60,
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                      color: AppColors.kGreyBg,
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,

                    initialValue: savingViewModel.selectedPlan.savingsAmount.toInt().toString(),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CurrencyPtBrInputFormatter(maxDigits: 11)
                    ],
                    onChanged: (value){
                      setState(() {
                        savingsAmount = double.parse(value.replaceAll(",", ""));
                      });
                    },
                    decoration: InputDecoration(
                        prefix: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Text(AppStrings.nairaSymbol, style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        border: InputBorder.none
                    ),
                  ),
                ),
                YMargin(20),
                Text("Funding source", style: TextStyle(fontSize: 15, fontFamily: AppStrings.fontBold),),
                YMargin(15),
                InkWell(
                  onTap: (){
                    showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
                      return FundingSourceWidget();
                    });
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    height: 60,
                    padding: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                        color: AppColors.kGreyBg,
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Row(children: [
                      Text(savingViewModel.selectedPlan.fundingChannelText == "Card" ? "Debit Card (ending with ${paymentViewModel.selectedCard.mp})":"Wallet"),
                      Spacer(),
                      Icon(Icons.keyboard_arrow_down_rounded, size: 30,),
                      XMargin(20)
                    ],),
                  ),
                ),
                YMargin(40),
                RoundedNextButton(
                  onTap: ()async{
                    EasyLoading.show(status: "");
                    var result = await savingViewModel.editTargetSavings(
                        image: _image,
                        cardId:paymentViewModel.selectedCard?.id ?? null,
                        token: identityViewModel.user.token,
                        fundingChannel: paymentViewModel.selectedCard == null ?
                        savingViewModel.fundingChannels.firstWhere((element) => element.name == "Wallet").id:
                        savingViewModel.fundingChannels.firstWhere((element) => element.name == "Card").id,
                        savingsAmount:savingsAmount == null ? savingViewModel.selectedPlan.savingsAmount.toInt(): savingsAmount.toInt()
                    );
                    if(result.error == false){
                      EasyLoading.showSuccess("Aspire Plan Saved",duration: Duration(seconds: 3)).then((value) {
                        Navigator.pop(context, 1);

                      });

                  }else{
                      EasyLoading.showError(result.errorMessage, duration: Duration(seconds: 3));
                    }
                  },
                ),
                YMargin(40),


            ],),
          ),
        ),
      ),
    );
  }
}
