class CompletedSections{
  CompletedSections({
    this.isProfileInformationProvided,
    this.isBvnProvided,
    this.isNextOfKinProvided,
    this.isNotificationConfigured,
    this.isKycProvided,
    this.kycValidationCheck,
  });

  bool isProfileInformationProvided;
  bool isBvnProvided;
  bool isNextOfKinProvided;
  bool isNotificationConfigured;
  bool isKycProvided;
  KycValidationCheck kycValidationCheck;

  factory CompletedSections.fromJson(Map<String, dynamic> json) => CompletedSections(
    isProfileInformationProvided: json["isProfileInformationProvided"],
    isBvnProvided: json["isBVNProvided"],
    isNextOfKinProvided: json["isNextOfKinProvided"],
    isNotificationConfigured: json["isNotificationConfigured"],
    isKycProvided: json["isKYCProvided"],
    kycValidationCheck: KycValidationCheck.fromJson(json["kycValidationCheck"]),
  );

  Map<String, dynamic> toJson() => {
    "isProfileInformationProvided": isProfileInformationProvided,
    "isBVNProvided": isBvnProvided,
    "isNextOfKinProvided": isNextOfKinProvided,
    "isNotificationConfigured": isNotificationConfigured,
    "isKYCProvided": isKycProvided,
    "kycValidationCheck": kycValidationCheck.toJson(),
  };
}

class KycValidationCheck {
  KycValidationCheck({
    this.isKycValidated,
    this.isBvnValid,
    this.isBirthDayAndGenderProvided,
  });

  bool isKycValidated;
  bool isBvnValid;
  bool isBirthDayAndGenderProvided;

  factory KycValidationCheck.fromJson(Map<String, dynamic> json) => KycValidationCheck(
    isKycValidated: json["isKYCValidated"],
    isBvnValid: json["isBVNValid"],
    isBirthDayAndGenderProvided: json["isBirthDayAndGenderProvided"],
  );

  Map<String, dynamic> toJson() => {
    "isKYCValidated": isKycValidated,
    "isBVNValid": isBvnValid,
    "isBirthDayAndGenderProvided": isBirthDayAndGenderProvided,
  };
}