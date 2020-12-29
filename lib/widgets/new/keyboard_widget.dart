import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/pin_view_model.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/strings.dart';

class KeyboardWidget extends StatelessWidget {

  final VoidCallback confirmCode;
  final int flex;

  const KeyboardWidget({Key key, this.confirmCode, this.flex = 4}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ABSPinViewModel pinViewModel = Provider.of(context);
    return Expanded(
      flex: flex,
      child: Container(
        child: Column(children: [
          Expanded(
            child: Row(children: [
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    if(pinViewModel.pin1.isEmpty){

                      pinViewModel.pin1 = "1";

                    }else if(pinViewModel.pin2.isEmpty){
                      pinViewModel.pin2 = "1";
                    }else if(pinViewModel.pin3.isEmpty){
                      pinViewModel.pin3 = "1";
                    }else if(pinViewModel.pin4.isEmpty){
                      pinViewModel.pin4 = "1";
                      confirmCode();
                    }
                  },
                  child: Container(
                    height: 50,
                    color: Colors.transparent,
                    child: Center(
                      child: Text("1", style: TextStyle(fontSize: 20,fontFamily: AppStrings.fontMedium),),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    if(pinViewModel.pin1.isEmpty){

                      pinViewModel.pin1 = "2";

                    }else if(pinViewModel.pin2.isEmpty){
                      pinViewModel.pin2 = "2";
                    }else if(pinViewModel.pin3.isEmpty){
                      pinViewModel.pin3 = "2";

                    }else if(pinViewModel.pin4.isEmpty){

                      pinViewModel.pin4 = "2";

                      confirmCode();
                    }
                  },
                  child: Container(
                    height: 50,
                    color: Colors.transparent,
                    child: Center(
                      child: Text("2", style: TextStyle(fontSize: 20,fontFamily: AppStrings.fontMedium),),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    if(pinViewModel.pin1.isEmpty){

                        pinViewModel.pin1 = "3";

                    }else if(pinViewModel.pin2.isEmpty){

                        pinViewModel.pin2 = "3";

                    }else if(pinViewModel.pin3.isEmpty){

                        pinViewModel.pin3 = "3";

                    }else if(pinViewModel.pin4.isEmpty){

                        pinViewModel.pin4 = "3";

                      confirmCode();
                    }
                  },
                  child: Container(
                    height: 50,
                    color: Colors.transparent,
                    child: Center(
                      child: Text("3", style: TextStyle(fontSize: 20,fontFamily: AppStrings.fontMedium),),
                    ),
                  ),
                ),
              ),
            ],),
          ),
          Expanded(
            child: Row(children: [
              Expanded(
                child: GestureDetector(
                  onTap:(){
                    if(pinViewModel.pin1.isEmpty){

                        pinViewModel.pin1 = "4";

                    }else if(pinViewModel.pin2.isEmpty){

                        pinViewModel.pin2 = "4";

                    }else if(pinViewModel.pin3.isEmpty){

                        pinViewModel.pin3 = "4";

                    }else if(pinViewModel.pin4.isEmpty){

                        pinViewModel.pin4 = "4";

                      confirmCode();
                    }
                  },
                  child: Container(
                    height: 50,
                    color: Colors.transparent,
                    child: Center(
                      child: Text("4", style: TextStyle(fontSize: 20,fontFamily: AppStrings.fontMedium),),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    if(pinViewModel.pin1.isEmpty){

                        pinViewModel.pin1 = "5";

                    }else if(pinViewModel.pin2.isEmpty){

                        pinViewModel.pin2 = "5";

                    }else if(pinViewModel.pin3.isEmpty){

                        pinViewModel.pin3 = "5";

                    }else if(pinViewModel.pin4.isEmpty){

                        pinViewModel.pin4 = "5";

                      confirmCode();
                    }
                  },
                  child: Container(
                    height: 50,
                    color: Colors.transparent,
                    child: Center(
                      child: Text("5", style: TextStyle(fontSize: 20,fontFamily: AppStrings.fontMedium),),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    if(pinViewModel.pin1.isEmpty){

                        pinViewModel.pin1 = "6";

                    }else if(pinViewModel.pin2.isEmpty){

                        pinViewModel.pin2 = "6";

                    }else if(pinViewModel.pin3.isEmpty){

                        pinViewModel.pin3 = "6";

                    }else if(pinViewModel.pin4.isEmpty){

                        pinViewModel.pin4 = "6";

                      confirmCode();
                    }
                  },
                  child: Container(
                    height: 50,
                    color: Colors.transparent,
                    child: Center(
                      child: Text("6", style: TextStyle(fontSize: 20,fontFamily: AppStrings.fontMedium),),
                    ),
                  ),
                ),
              ),
            ],),
          ),
          Expanded(
            child: Row(children: [
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    if(pinViewModel.pin1.isEmpty){

                        pinViewModel.pin1 = "7";

                    }else if(pinViewModel.pin2.isEmpty){

                        pinViewModel.pin2 = "7";

                    }else if(pinViewModel.pin3.isEmpty){

                        pinViewModel.pin3 = "7";

                    }else if(pinViewModel.pin4.isEmpty){

                        pinViewModel.pin4 = "7";

                      confirmCode();
                    }
                  },
                  child: Container(
                    height: 50,
                    color: Colors.transparent,
                    child: Center(
                      child: Text("7", style: TextStyle(fontSize: 20,fontFamily: AppStrings.fontMedium),),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    if(pinViewModel.pin1.isEmpty){

                        pinViewModel.pin1 = "8";

                    }else if(pinViewModel.pin2.isEmpty){

                        pinViewModel.pin2 = "8";

                    }else if(pinViewModel.pin3.isEmpty){

                        pinViewModel.pin3 = "8";

                    }else if(pinViewModel.pin4.isEmpty){

                        pinViewModel.pin4 = "8";

                      confirmCode();
                    }
                  },
                  child: Container(
                    height: 50,
                    color: Colors.transparent,
                    child: Center(
                      child: Text("8", style: TextStyle(fontSize: 20,fontFamily: AppStrings.fontMedium),),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    if(pinViewModel.pin1.isEmpty){

                        pinViewModel.pin1 = "9";

                    }else if(pinViewModel.pin2.isEmpty){

                        pinViewModel.pin2 = "9";

                    }else if(pinViewModel.pin3.isEmpty){

                        pinViewModel.pin3 = "9";

                    }else if(pinViewModel.pin4.isEmpty){

                        pinViewModel.pin4 = "9";

                      confirmCode();
                    }
                  },
                  child: Container(
                    height: 50,
                    color: Colors.transparent,
                    child: Center(
                      child: Text("9", style: TextStyle(fontSize: 20,fontFamily: AppStrings.fontMedium),),
                    ),
                  ),
                ),
              ),
            ],),
          ),
          Expanded(
            child: Row(children: [
              Expanded(
                child: Container(
                  height: 50,
                    color: Colors.transparent,
                  child: Center(
                    child: Text("", style: TextStyle(fontSize: 20),),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    if(pinViewModel.pin1.isEmpty){

                        pinViewModel.pin1 = "0";

                    }else if(pinViewModel.pin2.isEmpty){

                        pinViewModel.pin2 = "0";

                    }else if(pinViewModel.pin3.isEmpty){

                        pinViewModel.pin3 = "0";

                    }else if(pinViewModel.pin4.isEmpty){

                        pinViewModel.pin4 = "0";
                      confirmCode();
                    }
                  },
                  child: Container(
                    height: 50,
                    color: Colors.transparent,
                    child: Center(
                      child: Text("0", style: TextStyle(fontSize: 20,fontFamily: AppStrings.fontMedium),),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    if(pinViewModel.pin4.isNotEmpty){
                      pinViewModel.pin4 = '';
                    }else if(pinViewModel.pin3.isNotEmpty){
                      pinViewModel.pin3 = '';
                    }else if(pinViewModel.pin2.isNotEmpty){
                      pinViewModel.pin2 = '';
                    }else if(pinViewModel.pin1.isNotEmpty){
                      pinViewModel.pin1 = '';
                    }



                  },
                  child: Container(
                    height: 50,
                    color: Colors.transparent,
                    child: Center(
                      child: Icon(Icons.arrow_back_ios,size: 18,color: AppColors.kPrimaryColor,),
                    ),
                  ),
                ),
              ),
            ],),
          )
        ],),
      ),
    );
  }
}
class VerifyKeyboardWidget extends StatelessWidget {

  final VoidCallback confirmCode;
  final int flex;

  const VerifyKeyboardWidget({Key key, this.confirmCode, this.flex = 4}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ABSPinViewModel pinViewModel = Provider.of(context);
    return Expanded(
      flex: flex,
      child: Container(
        child: Column(children: [
          Expanded(
            child: Row(children: [
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    if(pinViewModel.pin1.isEmpty){

                      pinViewModel.pin1 = "1";

                    }else if(pinViewModel.pin2.isEmpty){
                      pinViewModel.pin2 = "1";
                    }else if(pinViewModel.pin3.isEmpty){
                      pinViewModel.pin3 = "1";
                    }else if(pinViewModel.pin4.isEmpty){
                      pinViewModel.pin4 = "1";
                    }else if(pinViewModel.pin5.isEmpty){
                      pinViewModel.pin5 = "1";

                    }else if(pinViewModel.pin6.isEmpty){
                      pinViewModel.pin6 = "1";
                      confirmCode();
                    }
                  },
                  child: Container(
                    height: 50,
                    color: Colors.transparent,
                    child: Center(
                      child: Text("1", style: TextStyle(fontSize: 20,fontFamily: AppStrings.fontMedium),),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    if(pinViewModel.pin1.isEmpty){

                      pinViewModel.pin1 = "2";

                    }else if(pinViewModel.pin2.isEmpty){
                      pinViewModel.pin2 = "2";
                    }else if(pinViewModel.pin3.isEmpty){
                      pinViewModel.pin3 = "2";

                    }else if(pinViewModel.pin4.isEmpty){
                      pinViewModel.pin4 = "2";
                    }else if(pinViewModel.pin5.isEmpty){
                      pinViewModel.pin5 = "2";

                    }else if(pinViewModel.pin6.isEmpty){
                      pinViewModel.pin6 = "2";
                      confirmCode();
                    }
                  },
                  child: Container(
                    height: 50,
                    color: Colors.transparent,
                    child: Center(
                      child: Text("2", style: TextStyle(fontSize: 20,fontFamily: AppStrings.fontMedium),),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    if(pinViewModel.pin1.isEmpty){

                        pinViewModel.pin1 = "3";

                    }else if(pinViewModel.pin2.isEmpty){

                        pinViewModel.pin2 = "3";

                    }else if(pinViewModel.pin3.isEmpty){

                        pinViewModel.pin3 = "3";

                    }else if(pinViewModel.pin4.isEmpty){
                      pinViewModel.pin4 = "3";
                    }else if(pinViewModel.pin5.isEmpty){
                      pinViewModel.pin5 = "3";

                    }else if(pinViewModel.pin6.isEmpty){
                      pinViewModel.pin6 = "3";
                      confirmCode();
                    }
                  },
                  child: Container(
                    height: 50,
                    color: Colors.transparent,
                    child: Center(
                      child: Text("3", style: TextStyle(fontSize: 20,fontFamily: AppStrings.fontMedium),),
                    ),
                  ),
                ),
              ),
            ],),
          ),
          Expanded(
            child: Row(children: [
              Expanded(
                child: GestureDetector(
                  onTap:(){
                    if(pinViewModel.pin1.isEmpty){

                        pinViewModel.pin1 = "4";

                    }else if(pinViewModel.pin2.isEmpty){

                        pinViewModel.pin2 = "4";

                    }else if(pinViewModel.pin3.isEmpty){

                        pinViewModel.pin3 = "4";

                    }else if(pinViewModel.pin4.isEmpty){
                      pinViewModel.pin4 = "4";
                    }else if(pinViewModel.pin5.isEmpty){
                      pinViewModel.pin5 = "4";

                    }else if(pinViewModel.pin6.isEmpty){
                      pinViewModel.pin6 = "4";
                      confirmCode();
                    }
                  },
                  child: Container(
                    height: 50,
                    color: Colors.transparent,
                    child: Center(
                      child: Text("4", style: TextStyle(fontSize: 20,fontFamily: AppStrings.fontMedium),),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    if(pinViewModel.pin1.isEmpty){

                        pinViewModel.pin1 = "5";

                    }else if(pinViewModel.pin2.isEmpty){

                        pinViewModel.pin2 = "5";

                    }else if(pinViewModel.pin3.isEmpty){

                        pinViewModel.pin3 = "5";

                    }else if(pinViewModel.pin4.isEmpty){
                      pinViewModel.pin4 = "5";
                    }else if(pinViewModel.pin5.isEmpty){
                      pinViewModel.pin5 = "5";

                    }else if(pinViewModel.pin6.isEmpty){
                      pinViewModel.pin6 = "5";
                      confirmCode();
                    }
                  },
                  child: Container(
                    height: 50,
                    color: Colors.transparent,
                    child: Center(
                      child: Text("5", style: TextStyle(fontSize: 20,fontFamily: AppStrings.fontMedium),),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    if(pinViewModel.pin1.isEmpty){

                        pinViewModel.pin1 = "6";

                    }else if(pinViewModel.pin2.isEmpty){

                        pinViewModel.pin2 = "6";

                    }else if(pinViewModel.pin3.isEmpty){

                        pinViewModel.pin3 = "6";

                    }else if(pinViewModel.pin4.isEmpty){
                      pinViewModel.pin4 = "6";
                    }else if(pinViewModel.pin5.isEmpty){
                      pinViewModel.pin5 = "6";

                    }else if(pinViewModel.pin6.isEmpty){
                      pinViewModel.pin6 = "6";
                      confirmCode();
                    }
                  },
                  child: Container(
                    height: 50,
                    color: Colors.transparent,
                    child: Center(
                      child: Text("6", style: TextStyle(fontSize: 20,fontFamily: AppStrings.fontMedium),),
                    ),
                  ),
                ),
              ),
            ],),
          ),
          Expanded(
            child: Row(children: [
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    if(pinViewModel.pin1.isEmpty){

                        pinViewModel.pin1 = "7";

                    }else if(pinViewModel.pin2.isEmpty){

                        pinViewModel.pin2 = "7";

                    }else if(pinViewModel.pin3.isEmpty){

                        pinViewModel.pin3 = "7";

                    }else if(pinViewModel.pin4.isEmpty){
                      pinViewModel.pin4 = "7";
                    }else if(pinViewModel.pin5.isEmpty){
                      pinViewModel.pin5 = "7";

                    }else if(pinViewModel.pin6.isEmpty){
                      pinViewModel.pin6 = "7";
                      confirmCode();
                    }
                  },
                  child: Container(
                    height: 50,
                    color: Colors.transparent,
                    child: Center(
                      child: Text("7", style: TextStyle(fontSize: 20,fontFamily: AppStrings.fontMedium),),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    if(pinViewModel.pin1.isEmpty){

                        pinViewModel.pin1 = "8";

                    }else if(pinViewModel.pin2.isEmpty){

                        pinViewModel.pin2 = "8";

                    }else if(pinViewModel.pin3.isEmpty){

                        pinViewModel.pin3 = "8";

                    }else if(pinViewModel.pin4.isEmpty){
                      pinViewModel.pin4 = "8";
                    }else if(pinViewModel.pin5.isEmpty){
                      pinViewModel.pin5 = "8";

                    }else if(pinViewModel.pin6.isEmpty){
                      pinViewModel.pin6 = "8";
                      confirmCode();
                    }
                  },
                  child: Container(
                    height: 50,
                    color: Colors.transparent,
                    child: Center(
                      child: Text("8", style: TextStyle(fontSize: 20,fontFamily: AppStrings.fontMedium),),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    if(pinViewModel.pin1.isEmpty){

                        pinViewModel.pin1 = "9";

                    }else if(pinViewModel.pin2.isEmpty){

                        pinViewModel.pin2 = "9";

                    }else if(pinViewModel.pin3.isEmpty){

                        pinViewModel.pin3 = "9";

                    }else if(pinViewModel.pin4.isEmpty){
                      pinViewModel.pin4 = "9";
                    }else if(pinViewModel.pin5.isEmpty){
                      pinViewModel.pin5 = "9";

                    }else if(pinViewModel.pin6.isEmpty){
                      pinViewModel.pin6 = "9";
                      confirmCode();
                    }
                  },
                  child: Container(
                    height: 50,
                    color: Colors.transparent,
                    child: Center(
                      child: Text("9", style: TextStyle(fontSize: 20,fontFamily: AppStrings.fontMedium),),
                    ),
                  ),
                ),
              ),
            ],),
          ),
          Expanded(
            child: Row(children: [
              Expanded(
                child: Container(
                  height: 50,
                    color: Colors.transparent,
                  child: Center(
                    child: Text("", style: TextStyle(fontSize: 20),),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    if(pinViewModel.pin1.isEmpty){

                        pinViewModel.pin1 = "0";

                    }else if(pinViewModel.pin2.isEmpty){

                        pinViewModel.pin2 = "0";

                    }else if(pinViewModel.pin3.isEmpty){

                        pinViewModel.pin3 = "0";

                    }else if(pinViewModel.pin4.isEmpty){
                      pinViewModel.pin4 = "0";
                    }else if(pinViewModel.pin5.isEmpty){
                      pinViewModel.pin5 = "0";

                    }else if(pinViewModel.pin6.isEmpty){
                      pinViewModel.pin6 = "0";
                      confirmCode();
                    }
                  },
                  child: Container(
                    height: 50,
                    color: Colors.transparent,
                    child: Center(
                      child: Text("0", style: TextStyle(fontSize: 20,fontFamily: AppStrings.fontMedium),),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    if(pinViewModel.pin6.isNotEmpty){
                      pinViewModel.pin6 = '';
                    }else if(pinViewModel.pin5.isNotEmpty){
                      pinViewModel.pin5 = '';
                    }else if(pinViewModel.pin4.isNotEmpty){
                      pinViewModel.pin4 = '';
                    }else if(pinViewModel.pin3.isNotEmpty){
                      pinViewModel.pin3 = '';
                    }else if(pinViewModel.pin2.isNotEmpty){
                      pinViewModel.pin2 = '';
                    }else if(pinViewModel.pin1.isNotEmpty){
                      pinViewModel.pin1 = '';
                    }



                  },
                  child: Container(
                    height: 50,
                    color: Colors.transparent,
                    child: Center(
                      child: Icon(Icons.arrow_back_ios,size: 18,color: AppColors.kPrimaryColor,),
                    ),
                  ),
                ),
              ),
            ],),
          )
        ],),
      ),
    );
  }
}
class NumKeyboardWidget extends StatelessWidget {


  final int flex;

  const NumKeyboardWidget({Key key, this.flex = 4}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ABSPinViewModel pinViewModel = Provider.of(context);
    return Expanded(
      flex: flex,
      child: Container(
        child: Column(children: [
          Expanded(
            child: Row(children: [
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    if(pinViewModel.amount.length > 11){
                      return;
                    }

                    pinViewModel.amount = pinViewModel.amount + "1";

                  },
                  child: Container(
                    height: 50,
                    color: Colors.transparent,
                    child: Center(
                      child: Text("1", style: TextStyle(fontSize: 20,fontFamily: AppStrings.fontMedium),),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    if(pinViewModel.amount.length > 11){
                      return;
                    }

                    pinViewModel.amount = pinViewModel.amount + "2";
                  },
                  child: Container(
                    height: 50,
                    color: Colors.transparent,
                    child: Center(
                      child: Text("2", style: TextStyle(fontSize: 20,fontFamily: AppStrings.fontMedium),),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    if(pinViewModel.amount.length > 11){
                      return;
                    }

                    pinViewModel.amount = pinViewModel.amount + "3";
                  },
                  child: Container(
                    height: 50,
                    color: Colors.transparent,
                    child: Center(
                      child: Text("3", style: TextStyle(fontSize: 20,fontFamily: AppStrings.fontMedium),),
                    ),
                  ),
                ),
              ),
            ],),
          ),
          Expanded(
            child: Row(children: [
              Expanded(
                child: GestureDetector(
                  onTap:(){
                    if(pinViewModel.amount.length > 11){
                      return;
                    }

                    pinViewModel.amount = pinViewModel.amount + "4";
                  },
                  child: Container(
                    height: 50,
                    color: Colors.transparent,
                    child: Center(
                      child: Text("4", style: TextStyle(fontSize: 20,fontFamily: AppStrings.fontMedium),),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    if(pinViewModel.amount.length > 11){
                      return;
                    }

                    pinViewModel.amount = pinViewModel.amount + "5";
                  },
                  child: Container(
                    height: 50,
                    color: Colors.transparent,
                    child: Center(
                      child: Text("5", style: TextStyle(fontSize: 20,fontFamily: AppStrings.fontMedium),),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    if(pinViewModel.amount.length > 11){
                      return;
                    }

                    pinViewModel.amount = pinViewModel.amount + "6";
                  },
                  child: Container(
                    height: 50,
                    color: Colors.transparent,
                    child: Center(
                      child: Text("6", style: TextStyle(fontSize: 20,fontFamily: AppStrings.fontMedium),),
                    ),
                  ),
                ),
              ),
            ],),
          ),
          Expanded(
            child: Row(children: [
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    if(pinViewModel.amount.length > 11){
                      return;
                    }

                    pinViewModel.amount = pinViewModel.amount + "7";
                  },
                  child: Container(
                    height: 50,
                    color: Colors.transparent,
                    child: Center(
                      child: Text("7", style: TextStyle(fontSize: 20,fontFamily: AppStrings.fontMedium),),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    if(pinViewModel.amount.length > 11){
                      return;
                    }

                    pinViewModel.amount = pinViewModel.amount + "8";
                  },
                  child: Container(
                    height: 50,
                    color: Colors.transparent,
                    child: Center(
                      child: Text("8", style: TextStyle(fontSize: 20,fontFamily: AppStrings.fontMedium),),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    if(pinViewModel.amount.length > 11){
                      return;
                    }

                    pinViewModel.amount = pinViewModel.amount + "9";
                  },
                  child: Container(
                    height: 50,
                    color: Colors.transparent,
                    child: Center(
                      child: Text("9", style: TextStyle(fontSize: 20,fontFamily: AppStrings.fontMedium),),
                    ),
                  ),
                ),
              ),
            ],),
          ),
          Expanded(
            child: Row(children: [
              Expanded(
                child: Container(
                  height: 50,
                    color: Colors.transparent,
                  child: Center(
                    child: Text("", style: TextStyle(fontSize: 20),),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    if(pinViewModel.amount.length > 11){
                      return;
                    }

                    pinViewModel.amount = pinViewModel.amount + "0";
                  },
                  child: Container(
                    height: 50,
                    color: Colors.transparent,
                    child: Center(
                      child: Text("0", style: TextStyle(fontSize: 20,fontFamily: AppStrings.fontMedium),),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){

                    if(pinViewModel.amount.length < 1){
                      return;
                    }
                    pinViewModel.amount = pinViewModel.amount.substring(0,
                        pinViewModel.amount.length -1);

                  },
                  child: Container(
                    height: 50,
                    color: Colors.transparent,
                    child: Center(
                      child: Icon(Icons.arrow_back_ios,size: 18,color: AppColors.kPrimaryColor,),
                    ),
                  ),
                ),
              ),
            ],),
          )
        ],),
      ),
    );
  }
}