
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:zimvest/data/models/completed_sections.dart';
import 'package:zimvest/data/models/individual/profile.dart';
import 'package:zimvest/data/services/account_settings_service.dart';
import 'package:zimvest/locator.dart';
import 'package:zimvest/utils/result.dart';

abstract class ABSSettingsViewModel extends ChangeNotifier{
  Profile _profile;
  Kin _kin;
  Notification _notification;
  String _bvn;
  CompletedSections _completedSections;
  int _selectedIdentity;
  int get selectedIdentity => _selectedIdentity;


  Profile get profile => _profile;
  CompletedSections get completedSections => _completedSections;
  String get bvn => _bvn;
  Kin get kin => _kin;
  Address _address;
  Notification get notification => _notification;
  Address get address => _address;

  set profile(Profile value);
  set bvn(String value);
  set selectedIdentity(int value);
  set kin(Kin value);
  set notification(Notification value);
  set address(Address value);
  set completedSections(CompletedSections value);

  
  Future<Result<Profile>> getProfileDetail({String token});
  Future<Result<Kin>> getNextOfKin({String token});
  Future<Result<String>> getBvn({String token});
  Future<Result<Notification>> getNotificationSettings({String token});
  Future<Result<Address>> getResidentialAddress({String token});
  Future<Result<CompletedSections>> getCompletedSections({String token});
  Future<Result<void>> uploadIdentification({String token, File file,String id});
  Future<Result<void>> uploadUtilityBill({String token, File file});
  Future<Result<void>> updateResidentialAddress({String token,
    String address, int state});
  Future<Result<void>> updateNotoficationSettings({String token,
    bool receiveEmailUpdateOnInvestment,
    bool receiveEmailUpdateOnSavings,
    bool subscribeToNewsLetter});
  Future<Result<void>> updateBvn({String token, String bvn});
  Future<Result<void>> updateProfile({String token, String firstName,
    String lastName, String email, String phoneNumber,
    String dOB, int gender, int maritalStatus, File profile1});
  Future<Result<void>> updateKin({String token, String fullName,
    int relationship, String email, String phoneNumber});

  Future<Result<void>> profileInvestor({String token,
    String firstName,
    int investmentKnowledge,
    int mostConernedDuringInvestment,
    int instrumentCurrentlyOwned,
    int marketAndParticularStockDrops,
    int hypotheticalInvestmentPlan,
    int investmentDurationBeforeWithdrawal,
    int durationToCompletelyWithdraw,
    bool ethicalConsideration,
    String email, String lastName});
  Future<Result<void>> checkipsstatus({String token});
}

class SettingsViewModel extends ABSSettingsViewModel{
  ABSSettingsService _settingsService = locator<ABSSettingsService>();


  @override
  set profile(Profile value) {
    _profile = value;
    notifyListeners();
  }

  @override
  set selectedIdentity(int value) {
    _selectedIdentity = value;
    notifyListeners();
  }

  @override
  set completedSections(CompletedSections value) {
    _completedSections = value;
    notifyListeners();
  }

  @override
  set bvn(String value) {
    _bvn = value;
    notifyListeners();
  }

  @override
  set address(Address value) {
    _address = value;
    notifyListeners();
  }

  @override
  set notification(Notification value) {
    _notification = value;
    notifyListeners();
  }
  @override
  set kin(Kin value) {
    _kin = value;
    notifyListeners();
  }




  @override
  Future<Result<Profile>> getProfileDetail({String token}) async{
    var result =await  _settingsService.getProfileDetail(
        token: token
    );
    if(result.error == false){
      profile = result.data;
    }

    return result;
  }

  @override
  Future<Result<Kin>> getNextOfKin({String token}) async{
    var result =await  _settingsService.getNextOfKin(
        token: token
    );
    if(result.error == false){
      kin = result.data;
    }

    return result;
  }

  @override
  Future<Result<Notification>> getNotificationSettings({String token})async {
    var result =await  _settingsService.getNotificationSettings(
        token: token
    );
    if(result.error == false){
      notification = result.data;
    }

    return result;
  }

  @override
  Future<Result<void>> uploadIdentification({String token, File file, String id}) {
    return _settingsService.uploadIdentification(token: token,file: file,id: id);
  }

  @override
  Future<Result<void>> uploadUtilityBill({String token, File file}) {
    return _settingsService.uploadUtilityBill(token: token,file: file);
  }

  @override
  Future<Result<void>> updateResidentialAddress({String token, String address, int state}) {
    return _settingsService.updateResidentialAddress(token: token,
        state: state,address: address);
  }

  @override
  Future<Result<Address>> getResidentialAddress({String token})async {
    var result =await _settingsService.getResidentialAddress(
        token: token
    );
    if(result.error == false){
      address = result.data;
    }

    return result;
  }

  @override
  Future<Result<String>> getBvn({String token}) async{
    var result =await _settingsService.getBvn(
        token: token
    );
    if(result.error == false){
      bvn = result.data;
    }

    return result;
  }

  @override
  Future<Result<CompletedSections>> getCompletedSections({String token}) async{
    var result =await _settingsService.getCompletedSections(
        token: token
    );
    if(result.error == false){
      completedSections = result.data;
    }

    return result;
  }

  @override
  Future<Result<void>> updateNotoficationSettings({String token, bool receiveEmailUpdateOnInvestment,
    bool receiveEmailUpdateOnSavings, bool subscribeToNewsLetter}) {
    return _settingsService.updateNotoficationSettings(
      token: token,
      receiveEmailUpdateOnInvestment: receiveEmailUpdateOnInvestment,
      receiveEmailUpdateOnSavings: receiveEmailUpdateOnSavings,
      subscribeToNewsLetter: subscribeToNewsLetter
    );
  }

  @override
  Future<Result<void>> updateBvn({String token, String bvn}) {
    return _settingsService.updateBvn(token: token,bvn: bvn);
  }

  @override
  Future<Result<void>> updateProfile({String token, String firstName, String lastName, String email,
    String phoneNumber, String dOB, int gender, int maritalStatus, File profile1}) async{


    return _settingsService.updateProfile(
      token: token,
      lastName: lastName,
      firstName: firstName,
      email: email,
      phoneNumber: phoneNumber,
      maritalStatus: maritalStatus,
      gender: gender,
      dOB: dOB,
        profile:profile1
    );
  }

  @override
  Future<Result<void>> updateKin({String token, String fullName,
    int relationship, String email, String phoneNumber}) {
   return _settingsService.updateKin(
     fullName: fullName,
     token: token,
     relationship: relationship,
     email: email,
     phoneNumber: phoneNumber
   );
  }


  @override
  Future<Result<void>> profileInvestor({String token, String firstName,
    int investmentKnowledge, int mostConernedDuringInvestment,
    int instrumentCurrentlyOwned, int marketAndParticularStockDrops,
    int hypotheticalInvestmentPlan, int investmentDurationBeforeWithdrawal,
    int durationToCompletelyWithdraw,
    bool ethicalConsideration, String email, String lastName}) {
    return _settingsService.profileInvestor(
      firstName: firstName,
      lastName: lastName,
      email: email,
      ethicalConsideration: ethicalConsideration,
      marketAndParticularStockDrops: marketAndParticularStockDrops,
      mostConernedDuringInvestment: mostConernedDuringInvestment,
      durationToCompletelyWithdraw: durationToCompletelyWithdraw,
      instrumentCurrentlyOwned: instrumentCurrentlyOwned,
      investmentDurationBeforeWithdrawal: investmentDurationBeforeWithdrawal,
      investmentKnowledge: investmentKnowledge,
      hypotheticalInvestmentPlan: hypotheticalInvestmentPlan
    );
  }

  @override
  Future<Result<void>> checkipsstatus({String token}) {
    return _settingsService.checkipsstatus(token: token);
  }


}