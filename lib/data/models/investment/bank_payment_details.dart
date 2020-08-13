class BankPaymentDetails {
  BankPaymentDetails({
    this.transactionAmount,
    this.paymentReference,
    this.paymentBanks,
  });

  String transactionAmount;
  String paymentReference;
  List<PaymentBank> paymentBanks;

  factory BankPaymentDetails.fromJson(Map<String, dynamic> json) => BankPaymentDetails(
    transactionAmount: json["transactionAmount"],
    paymentReference: json["paymentReference"],
    paymentBanks: List<PaymentBank>.from(json["paymentBanks"].map((x) => PaymentBank.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "transactionAmount": transactionAmount,
    "paymentReference": paymentReference,
    "paymentBanks": List<dynamic>.from(paymentBanks.map((x) => x.toJson())),
  };
}

class PaymentBank {
  PaymentBank({
    this.accountName,
    this.bankName,
    this.accountNumer,
  });

  String accountName;
  String bankName;
  String accountNumer;

  factory PaymentBank.fromJson(Map<String, dynamic> json) => PaymentBank(
    accountName: json["accountName"],
    bankName: json["bankName"],
    accountNumer: json["accountNumer"],
  );

  Map<String, dynamic> toJson() => {
    "accountName": accountName,
    "bankName": bankName,
    "accountNumer": accountNumer,
  };
}