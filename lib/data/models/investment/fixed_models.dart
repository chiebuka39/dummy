class CommercialPaper {
  CommercialPaper({
    this.id,
    this.commercialPaperName,
    this.investmentType,
    this.investmentCategory,
    this.maturityPeriod,
    this.maturityDate,
    this.yieldRate,
  });

  int id;
  String commercialPaperName;
  int investmentType;
  int investmentCategory;
  int maturityPeriod;
  String maturityDate;
  String yieldRate;

  factory CommercialPaper.fromJson(Map<String, dynamic> json) => CommercialPaper(
    id: json["id"],
    commercialPaperName: json["commercialPaperName"],
    investmentType: json["investmentType"],
    investmentCategory: json["investmentCategory"],
    maturityPeriod: json["maturityPeriod"],
    maturityDate: json["maturityDate"],
    yieldRate: json["yieldRate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "commercialPaperName": commercialPaperName,
    "investmentType": investmentType,
    "investmentCategory": investmentCategory,
    "maturityPeriod": maturityPeriod,
    "maturityDate": maturityDate,
    "yieldRate": yieldRate,
  };
}


class TreasuryBill {
  TreasuryBill({
    this.id,
    this.treasuryBillName,
    this.investmentType,
    this.investmentCategory,
    this.maturityPeriod,
    this.maturityDate,
    this.interestRate,
  });

  int id;
  String treasuryBillName;
  int investmentType;
  int investmentCategory;
  int maturityPeriod;
  String maturityDate;
  String interestRate;

  factory TreasuryBill.fromJson(Map<String, dynamic> json) => TreasuryBill(
    id: json["id"],
    treasuryBillName: json["treasuryBillName"],
    investmentType: json["investmentType"],
    investmentCategory: json["investmentCategory"],
    maturityPeriod: json["maturityPeriod"],
    maturityDate: json["maturityDate"],
    interestRate: json["interestRate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "treasuryBillName": treasuryBillName,
    "investmentType": investmentType,
    "investmentCategory": investmentCategory,
    "maturityPeriod": maturityPeriod,
    "maturityDate": maturityDate,
    "interestRate": interestRate,
  };
}

class FGNBond {
  FGNBond({
    this.id,
    this.bondName,
    this.investmentType,
    this.investmentCategory,
    this.maturityDate,
  });

  int id;
  String bondName;
  int investmentType;
  int investmentCategory;
  String maturityDate;

  factory FGNBond.fromJson(Map<String, dynamic> json) => FGNBond(
    id: json["id"],
    bondName: json["bondName"],
    investmentType: json["investmentType"],
    investmentCategory: json["investmentCategory"],
    maturityDate: json["maturityDate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bondName": bondName,
    "investmentType": investmentType,
    "investmentCategory": investmentCategory,
    "maturityDate": maturityDate,
  };
}

class CorporateBond {
  CorporateBond({
    this.id,
    this.corporateBondName,
    this.investmentType,
    this.investmentCategory,
    this.maturityDate,
  });

  int id;
  String corporateBondName;
  int investmentType;
  int investmentCategory;
  String maturityDate;

  factory CorporateBond.fromJson(Map<String, dynamic> json) => CorporateBond(
    id: json["id"],
    corporateBondName: json["corporateBondName"],
    investmentType: json["investmentType"],
    investmentCategory: json["investmentCategory"],
    maturityDate: json["maturityDate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "corporateBondName": corporateBondName,
    "investmentType": investmentType,
    "investmentCategory": investmentCategory,
    "maturityDate": maturityDate,
  };
}

class EuroBond {
  EuroBond({
    this.id,
    this.euroBondName,
    this.investmentType,
    this.investmentCategory,
    this.couponRate,
    this.maturityYear,
  });

  int id;
  String euroBondName;
  int investmentType;
  int investmentCategory;
  String couponRate;
  int maturityYear;

  factory EuroBond.fromJson(Map<String, dynamic> json) => EuroBond(
    id: json["id"],
    euroBondName: json["euroBondName"],
    investmentType: json["investmentType"],
    investmentCategory: json["investmentCategory"],
    couponRate: json["couponRate"],
    maturityYear: json["maturityYear"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "euroBondName": euroBondName,
    "investmentType": investmentType,
    "investmentCategory": investmentCategory,
    "couponRate": couponRate,
    "maturityYear": maturityYear,
  };
}

class PromissoryNote {
  PromissoryNote({
    this.id,
    this.promissoryNoteName,
    this.investmentType,
    this.investmentCategory,
    this.yieldRate,
    this.maturityDate,
  });

  int id;
  String promissoryNoteName;
  int investmentType;
  int investmentCategory;
  String yieldRate;
  String maturityDate;

  factory PromissoryNote.fromJson(Map<String, dynamic> json) => PromissoryNote(
    id: json["id"],
    promissoryNoteName: json["promissoryNoteName"],
    investmentType: json["investmentType"],
    investmentCategory: json["investmentCategory"],
    yieldRate: json["yieldRate"],
    maturityDate: json["maturityDate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "promissoryNoteName": promissoryNoteName,
    "investmentType": investmentType,
    "investmentCategory": investmentCategory,
    "yieldRate": yieldRate,
    "maturityDate": maturityDate,
  };
}