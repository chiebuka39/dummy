class Profile {
  Profile({
    this.profileId,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.dob,
    this.gender,
    this.maritalStatus,
    this.photoFile,
    this.userType,
  });

  int profileId;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  DateTime dob;
  int gender;
  int maritalStatus;
  String photoFile;
  String userType;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    profileId: json["profileId"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    dob: DateTime.parse(json["dob"]),
    gender: json["gender"],
    maritalStatus: json["maritalStatus"],
    photoFile: json["photoFile"],
    userType: json["userType"],
  );

  Map<String, dynamic> toJson() => {
    "profileId": profileId,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "phoneNumber": phoneNumber,
    "dob": dob.toIso8601String(),
    "gender": gender,
    "maritalStatus": maritalStatus,
    "photoFile": photoFile,
    "userType": userType,
  };
}

class Kin {
  Kin({
    this.customerId,
    this.fullName,
    this.relationship,
    this.email,
    this.phoneNumber,
  });

  int customerId;
  String fullName;
  String relationship;
  String email;
  String phoneNumber;

  factory Kin.fromJson(Map<String, dynamic> json) => Kin(
    customerId: json["customerId"],
    fullName: json["fullName"],
    relationship: json["relationship"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
  );

  Map<String, dynamic> toJson() => {
    "customerId": customerId,
    "fullName": fullName,
    "relationship": relationship,
    "email": email,
    "phoneNumber": phoneNumber,
  };
}

class Notification {
  Notification({
    this.id,
    this.receiveEmailUpdateOnInvestment,
    this.receiveEmailUpdateOnSavings,
    this.subscribeToNewsLetter,
    this.dateCreated,
  });

  int id;
  bool receiveEmailUpdateOnInvestment;
  bool receiveEmailUpdateOnSavings;
  bool subscribeToNewsLetter;
  DateTime dateCreated;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    id: json["id"],
    receiveEmailUpdateOnInvestment: json["receiveEmailUpdateOnInvestment"],
    receiveEmailUpdateOnSavings: json["receiveEmailUpdateOnSavings"],
    subscribeToNewsLetter: json["subscribeToNewsLetter"],
    dateCreated: DateTime.parse(json["dateCreated"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "receiveEmailUpdateOnInvestment": receiveEmailUpdateOnInvestment,
    "receiveEmailUpdateOnSavings": receiveEmailUpdateOnSavings,
    "subscribeToNewsLetter": subscribeToNewsLetter,
    "dateCreated": dateCreated.toIso8601String(),
  };
}

class IdentificationRequirement {
  IdentificationRequirement({
    this.isIdentificationRequirementProvided,
    this.isBvnProvided,
    this.isGovernmentIdentificationProvided,
    this.isUtilityBillProvided,
  });

  bool isIdentificationRequirementProvided;
  bool isBvnProvided;
  bool isGovernmentIdentificationProvided;
  bool isUtilityBillProvided;

  factory IdentificationRequirement.fromJson(Map<String, dynamic> json) => IdentificationRequirement(
    isIdentificationRequirementProvided: json["isIdentificationRequirementProvided"],
    isBvnProvided: json["isBVNProvided"],
    isGovernmentIdentificationProvided: json["isGovernmentIdentificationProvided"],
    isUtilityBillProvided: json["isUtilityBillProvided"],
  );

  Map<String, dynamic> toJson() => {
    "isIdentificationRequirementProvided": isIdentificationRequirementProvided,
    "isBVNProvided": isBvnProvided,
    "isGovernmentIdentificationProvided": isGovernmentIdentificationProvided,
    "isUtilityBillProvided": isUtilityBillProvided,
  };
}

class Address {
  Address({
    this.residentialAddress,
    this.state,
  });

  String residentialAddress;
  String state;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    residentialAddress: json["residentialAddress"],
    state: json["state"],
  );

  Map<String, dynamic> toJson() => {
    "residentialAddress": residentialAddress,
    "state": state,
  };
}

