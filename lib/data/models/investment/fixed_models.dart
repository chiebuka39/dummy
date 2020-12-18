class CommercialPaper {
  List<ComercialPaperItems> comercialPaperItems;

  CommercialPaper({this.comercialPaperItems});

  CommercialPaper.fromJson(Map<String, dynamic> json) {
    if (json['comercialPaperItems'] != null) {
      comercialPaperItems = new List<ComercialPaperItems>();
      json['comercialPaperItems'].forEach((v) {
        comercialPaperItems.add(new ComercialPaperItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.comercialPaperItems != null) {
      data['comercialPaperItems'] =
          this.comercialPaperItems.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ComercialPaperItems {
  String tenorBandName;
  List<CommercialPapers> commercialPapers;

  ComercialPaperItems({this.tenorBandName, this.commercialPapers});

  ComercialPaperItems.fromJson(Map<String, dynamic> json) {
    tenorBandName = json['tenorBandName'];
    if (json['commercialPapers'] != null) {
      commercialPapers = new List<CommercialPapers>();
      json['commercialPapers'].forEach((v) {
        commercialPapers.add(new CommercialPapers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tenorBandName'] = this.tenorBandName;
    if (this.commercialPapers != null) {
      data['commercialPapers'] =
          this.commercialPapers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommercialPapers {
  int id;
  String bondName;
  int investmentType;
  int investmentCategory;
  String maturityDate;
  int maturityPeriod;
  int instrumentId;
  String yieldRate;
  String investmentMaturityDate;
  double rate;

  CommercialPapers(
      {this.id,
      this.bondName,
      this.investmentType,
      this.investmentCategory,
      this.maturityDate,
      this.maturityPeriod,
      this.instrumentId,
      this.yieldRate,
      this.investmentMaturityDate,
      this.rate});

  CommercialPapers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bondName = json['bondName'];
    investmentType = json['investmentType'];
    investmentCategory = json['investmentCategory'];
    maturityDate = json['maturityDate'];
    maturityPeriod = json['maturityPeriod'];
    instrumentId = json['instrumentId'];
    yieldRate = json['yieldRate'];
    investmentMaturityDate = json['investmentMaturityDate'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bondName'] = this.bondName;
    data['investmentType'] = this.investmentType;
    data['investmentCategory'] = this.investmentCategory;
    data['maturityDate'] = this.maturityDate;
    data['maturityPeriod'] = this.maturityPeriod;
    data['instrumentId'] = this.instrumentId;
    data['yieldRate'] = this.yieldRate;
    data['investmentMaturityDate'] = this.investmentMaturityDate;
    data['rate'] = this.rate;
    return data;
  }
}

class TreasuryBill {
  List<TBillsItems> tBillsItems;

  TreasuryBill({this.tBillsItems});

  TreasuryBill.fromJson(Map<String, dynamic> json) {
    if (json['tBillsItems'] != null) {
      tBillsItems = new List<TBillsItems>();
      json['tBillsItems'].forEach((v) {
        tBillsItems.add(new TBillsItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tBillsItems != null) {
      data['tBillsItems'] = this.tBillsItems.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TBillsItems {
  String tenorBandName;
  List<TreasureBills> treasureBills;

  TBillsItems({this.tenorBandName, this.treasureBills});

  TBillsItems.fromJson(Map<String, dynamic> json) {
    tenorBandName = json['tenorBandName'];
    if (json['treasureBills'] != null) {
      treasureBills = new List<TreasureBills>();
      json['treasureBills'].forEach((v) {
        treasureBills.add(new TreasureBills.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tenorBandName'] = this.tenorBandName;
    if (this.treasureBills != null) {
      data['treasureBills'] =
          this.treasureBills.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TreasureBills {
  int id;
  String treasuryBillName;
  int investmentType;
  int investmentCategory;
  int maturityPeriod;
  String maturityDate;
  String interestRate;
  int instrumentId;
  String investmentMaturityDate;
  double rate;

  TreasureBills(
      {this.id,
      this.treasuryBillName,
      this.investmentType,
      this.investmentCategory,
      this.maturityPeriod,
      this.maturityDate,
      this.interestRate,
      this.instrumentId,
      this.investmentMaturityDate,
      this.rate});

  TreasureBills.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    treasuryBillName = json['treasuryBillName'];
    investmentType = json['investmentType'];
    investmentCategory = json['investmentCategory'];
    maturityPeriod = json['maturityPeriod'];
    maturityDate = json['maturityDate'];
    interestRate = json['interestRate'];
    instrumentId = json['instrumentId'];
    investmentMaturityDate = json['investmentMaturityDate'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['treasuryBillName'] = this.treasuryBillName;
    data['investmentType'] = this.investmentType;
    data['investmentCategory'] = this.investmentCategory;
    data['maturityPeriod'] = this.maturityPeriod;
    data['maturityDate'] = this.maturityDate;
    data['interestRate'] = this.interestRate;
    data['instrumentId'] = this.instrumentId;
    data['investmentMaturityDate'] = this.investmentMaturityDate;
    data['rate'] = this.rate;
    return data;
  }
}



class FGNBond {
  List<FgnBondItems> fgnBondItems;

  FGNBond({this.fgnBondItems});

  FGNBond.fromJson(Map<String, dynamic> json) {
    if (json['fgnBondItems'] != null) {
      fgnBondItems = new List<FgnBondItems>();
      json['fgnBondItems'].forEach((v) {
        fgnBondItems.add(new FgnBondItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fgnBondItems != null) {
      data['fgnBondItems'] = this.fgnBondItems.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FgnBondItems {
  String tenorBandName;
  List<FGNBonds> bonds;

  FgnBondItems({this.tenorBandName, this.bonds});

  FgnBondItems.fromJson(Map<String, dynamic> json) {
    tenorBandName = json['tenorBandName'];
    if (json['bonds'] != null) {
      bonds = new List<FGNBonds>();
      json['bonds'].forEach((v) {
        bonds.add(new FGNBonds.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tenorBandName'] = this.tenorBandName;
    if (this.bonds != null) {
      data['bonds'] = this.bonds.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FGNBonds {
  int id;
  String bondName;
  int investmentType;
  int investmentCategory;
  String maturityDate;
  int maturityPeriod;
  int instrumentId;
  String yieldRate;
  String investmentMaturityDate;
  double rate;

  FGNBonds(
      {this.id,
      this.bondName,
      this.investmentType,
      this.investmentCategory,
      this.maturityDate,
      this.maturityPeriod,
      this.instrumentId,
      this.yieldRate,
      this.investmentMaturityDate,
      this.rate});

  FGNBonds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bondName = json['bondName'];
    investmentType = json['investmentType'];
    investmentCategory = json['investmentCategory'];
    maturityDate = json['maturityDate'];
    maturityPeriod = json['maturityPeriod'];
    instrumentId = json['instrumentId'];
    yieldRate = json['yieldRate'];
    investmentMaturityDate = json['investmentMaturityDate'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bondName'] = this.bondName;
    data['investmentType'] = this.investmentType;
    data['investmentCategory'] = this.investmentCategory;
    data['maturityDate'] = this.maturityDate;
    data['maturityPeriod'] = this.maturityPeriod;
    data['instrumentId'] = this.instrumentId;
    data['yieldRate'] = this.yieldRate;
    data['investmentMaturityDate'] = this.investmentMaturityDate;
    data['rate'] = this.rate;
    return data;
  }
}

class CorporateBond {
  List<CorporateBondItems> corporateBondItems;

  CorporateBond({this.corporateBondItems});

  CorporateBond.fromJson(Map<String, dynamic> json) {
    if (json['corporateBondItems'] != null) {
      corporateBondItems = new List<CorporateBondItems>();
      json['corporateBondItems'].forEach((v) {
        corporateBondItems.add(new CorporateBondItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.corporateBondItems != null) {
      data['corporateBondItems'] =
          this.corporateBondItems.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CorporateBondItems {
  String tenorBandName;
  List<CorporateBondBonds> corporateBondBonds;

  CorporateBondItems({this.tenorBandName, this.corporateBondBonds});

  CorporateBondItems.fromJson(Map<String, dynamic> json) {
    tenorBandName = json['tenorBandName'];
    if (json['corporateBondBonds'] != null) {
      corporateBondBonds = new List<CorporateBondBonds>();
      json['corporateBondBonds'].forEach((v) {
        corporateBondBonds.add(new CorporateBondBonds.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tenorBandName'] = this.tenorBandName;
    if (this.corporateBondBonds != null) {
      data['corporateBondBonds'] =
          this.corporateBondBonds.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CorporateBondBonds {
  int id;
  String bondName;
  int investmentType;
  int investmentCategory;
  String maturityDate;
  int maturityPeriod;
  int instrumentId;
  String yieldRate;
  String investmentMaturityDate;
  double rate;

  CorporateBondBonds(
      {this.id,
      this.bondName,
      this.investmentType,
      this.investmentCategory,
      this.maturityDate,
      this.maturityPeriod,
      this.instrumentId,
      this.yieldRate,
      this.investmentMaturityDate,
      this.rate});

  CorporateBondBonds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bondName = json['bondName'];
    investmentType = json['investmentType'];
    investmentCategory = json['investmentCategory'];
    maturityDate = json['maturityDate'];
    maturityPeriod = json['maturityPeriod'];
    instrumentId = json['instrumentId'];
    yieldRate = json['yieldRate'];
    investmentMaturityDate = json['investmentMaturityDate'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bondName'] = this.bondName;
    data['investmentType'] = this.investmentType;
    data['investmentCategory'] = this.investmentCategory;
    data['maturityDate'] = this.maturityDate;
    data['maturityPeriod'] = this.maturityPeriod;
    data['instrumentId'] = this.instrumentId;
    data['yieldRate'] = this.yieldRate;
    data['investmentMaturityDate'] = this.investmentMaturityDate;
    data['rate'] = this.rate;
    return data;
  }
}
class EuroBond {
  List<EuroBondItems> euroBondItems;

  EuroBond({this.euroBondItems});

  EuroBond.fromJson(Map<String, dynamic> json) {
    if (json['euroBondItems'] != null) {
      euroBondItems = new List<EuroBondItems>();
      json['euroBondItems'].forEach((v) {
        euroBondItems.add(new EuroBondItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.euroBondItems != null) {
      data['euroBondItems'] =
          this.euroBondItems.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EuroBondItems {
  String tenorBandName;
  List<Bonds> bonds;

  EuroBondItems({this.tenorBandName, this.bonds});

  EuroBondItems.fromJson(Map<String, dynamic> json) {
    tenorBandName = json['tenorBandName'];
    if (json['bonds'] != null) {
      bonds = new List<Bonds>();
      json['bonds'].forEach((v) {
        bonds.add(new Bonds.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tenorBandName'] = this.tenorBandName;
    if (this.bonds != null) {
      data['bonds'] = this.bonds.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Bonds {
  int id;
  String euroBondName;
  int investmentType;
  int investmentCategory;
  String couponRate;
  int maturityYear;
  int maturityPeriod;
  int instrumentId;
  String yieldRate;
  String investmentMaturityDate;
  double rate;

  Bonds(
      {this.id,
      this.euroBondName,
      this.investmentType,
      this.investmentCategory,
      this.couponRate,
      this.maturityYear,
      this.maturityPeriod,
      this.instrumentId,
      this.yieldRate,
      this.investmentMaturityDate,
      this.rate});

  Bonds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    euroBondName = json['euroBondName'];
    investmentType = json['investmentType'];
    investmentCategory = json['investmentCategory'];
    couponRate = json['couponRate'];
    maturityYear = json['maturityYear'];
    maturityPeriod = json['maturityPeriod'];
    instrumentId = json['instrumentId'];
    yieldRate = json['yieldRate'];
    investmentMaturityDate = json['investmentMaturityDate'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['euroBondName'] = this.euroBondName;
    data['investmentType'] = this.investmentType;
    data['investmentCategory'] = this.investmentCategory;
    data['couponRate'] = this.couponRate;
    data['maturityYear'] = this.maturityYear;
    data['maturityPeriod'] = this.maturityPeriod;
    data['instrumentId'] = this.instrumentId;
    data['yieldRate'] = this.yieldRate;
    data['investmentMaturityDate'] = this.investmentMaturityDate;
    data['rate'] = this.rate;
    return data;
  }
}

class PromissoryNote {
  List<PromissoryNoteItems> promissoryNoteItems;

  PromissoryNote({this.promissoryNoteItems});

  PromissoryNote.fromJson(Map<String, dynamic> json) {
    if (json['promissoryNoteItems'] != null) {
      promissoryNoteItems = new List<PromissoryNoteItems>();
      json['promissoryNoteItems'].forEach((v) {
        promissoryNoteItems.add(new PromissoryNoteItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.promissoryNoteItems != null) {
      data['promissoryNoteItems'] =
          this.promissoryNoteItems.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PromissoryNoteItems {
  String tenorBandName;
  List<PromissoryNotes> promissoryNotes;

  PromissoryNoteItems({this.tenorBandName, this.promissoryNotes});

  PromissoryNoteItems.fromJson(Map<String, dynamic> json) {
    tenorBandName = json['tenorBandName'];
    if (json['promissoryNotes'] != null) {
      promissoryNotes = new List<PromissoryNotes>();
      json['promissoryNotes'].forEach((v) {
        promissoryNotes.add(new PromissoryNotes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tenorBandName'] = this.tenorBandName;
    if (this.promissoryNotes != null) {
      data['promissoryNotes'] =
          this.promissoryNotes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PromissoryNotes {
  int id;
  String promissoryNoteName;
  int investmentType;
  int investmentCategory;
  String yieldRate;
  String maturityDate;
  int maturityPeriod;
  int instrumentId;
  String investmentMaturityDate;
  double rate;

  PromissoryNotes(
      {this.id,
      this.promissoryNoteName,
      this.investmentType,
      this.investmentCategory,
      this.yieldRate,
      this.maturityDate,
      this.maturityPeriod,
      this.instrumentId,
      this.investmentMaturityDate,
      this.rate});

  PromissoryNotes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    promissoryNoteName = json['promissoryNoteName'];
    investmentType = json['investmentType'];
    investmentCategory = json['investmentCategory'];
    yieldRate = json['yieldRate'];
    maturityDate = json['maturityDate'];
    maturityPeriod = json['maturityPeriod'];
    instrumentId = json['instrumentId'];
    investmentMaturityDate = json['investmentMaturityDate'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['promissoryNoteName'] = this.promissoryNoteName;
    data['investmentType'] = this.investmentType;
    data['investmentCategory'] = this.investmentCategory;
    data['yieldRate'] = this.yieldRate;
    data['maturityDate'] = this.maturityDate;
    data['maturityPeriod'] = this.maturityPeriod;
    data['instrumentId'] = this.instrumentId;
    data['investmentMaturityDate'] = this.investmentMaturityDate;
    data['rate'] = this.rate;
    return data;
  }
}