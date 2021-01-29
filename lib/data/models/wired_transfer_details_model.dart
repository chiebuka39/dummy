class WiredTransferDetails {
  int id;
  String beneficiaryName;
  String beneficiaryAddress;
  String beneficiaryBank;
  String beneficiaryAccountNumer;
  String correspondenceBankAccountNumer;
  String beneficiaryBankSwiftCode;
  String intermediaryBankName;
  String intermediaryAddress;
  String intermediaryBankAccountNumber;
  String intermediarySwiftCode;
  String intermediaryRoutingNumber;

  WiredTransferDetails(
      {this.id,
      this.beneficiaryName,
      this.beneficiaryAddress,
      this.beneficiaryBank,
      this.beneficiaryAccountNumer,
      this.correspondenceBankAccountNumer,
      this.beneficiaryBankSwiftCode,
      this.intermediaryBankName,
      this.intermediaryAddress,
      this.intermediaryBankAccountNumber,
      this.intermediarySwiftCode,
      this.intermediaryRoutingNumber});

  WiredTransferDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    beneficiaryName = json['beneficiaryName'];
    beneficiaryAddress = json['beneficiaryAddress'];
    beneficiaryBank = json['beneficiaryBank'];
    beneficiaryAccountNumer = json['beneficiaryAccountNumer'];
    correspondenceBankAccountNumer = json['correspondenceBankAccountNumer'];
    beneficiaryBankSwiftCode = json['beneficiaryBankSwiftCode'];
    intermediaryBankName = json['intermediaryBankName'];
    intermediaryAddress = json['intermediaryAddress'];
    intermediaryBankAccountNumber = json['intermediaryBankAccountNumber'];
    intermediarySwiftCode = json['intermediarySwiftCode'];
    intermediaryRoutingNumber = json['intermediaryRoutingNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['beneficiaryName'] = this.beneficiaryName;
    data['beneficiaryAddress'] = this.beneficiaryAddress;
    data['beneficiaryBank'] = this.beneficiaryBank;
    data['beneficiaryAccountNumer'] = this.beneficiaryAccountNumer;
    data['correspondenceBankAccountNumer'] =
        this.correspondenceBankAccountNumer;
    data['beneficiaryBankSwiftCode'] = this.beneficiaryBankSwiftCode;
    data['intermediaryBankName'] = this.intermediaryBankName;
    data['intermediaryAddress'] = this.intermediaryAddress;
    data['intermediaryBankAccountNumber'] = this.intermediaryBankAccountNumber;
    data['intermediarySwiftCode'] = this.intermediarySwiftCode;
    data['intermediaryRoutingNumber'] = this.intermediaryRoutingNumber;
    return data;
  }
}