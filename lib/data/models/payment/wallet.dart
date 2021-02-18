import 'package:zimvest/data/models/payment/bank.dart';

class Wallet{
  String walletNum;
  String currency;
  int walletId;
  double balance;
  List<Bank> virtualAccounts;


  Wallet({this.balance, this.walletNum, this.walletId,this.currency, this.virtualAccounts});

  factory Wallet.fromJson2(Map<String, dynamic> json) => Wallet(
    walletNum: json["walletNumber"],
    balance: json["walletBalance"],
    currency: json["currency"],
    walletId: json["walletId"],
  );
  Wallet.fromJson(Map<String, dynamic> json){
    walletNum= json["walletNumber"];
    balance= json["walletBalance"];
    currency= json["currency"];
    walletId= json["walletId"];
    if (json['virtualAccounts'] != null) {
      virtualAccounts = new List<Bank>();
      json['virtualAccounts'].forEach((v) {
        Bank gg = Bank.fromJsonMain(v);
        virtualAccounts.add(gg);
      });
    }
  }

  Map<String, dynamic> toJson() => {
    "walletNumber": walletNum,
    "balance": balance,
  };
}

class WalletTransaction {
  WalletTransaction({
    this.amount,
    this.currency,
    this.movementType,
    this.transactionReference,
    this.paymentReference,
    this.narration,
    this.transactionStatus,
    this.date,
    this.dateFilter,
  });

  num amount;
  String currency;
  String movementType;
  String transactionReference;
  String paymentReference;
  String narration;
  String transactionStatus;
  String date;
  DateTime dateFilter;

  factory WalletTransaction.fromJson(Map<String, dynamic> json) => WalletTransaction(
    amount: json["amount"],
    currency: json["currency"],
    movementType: json["movementType"],
    transactionReference: json["transactionReference"],
    paymentReference: json["paymentReference"],
    narration: json["narration"],
    transactionStatus: json["transactionStatus"],
    date: json["date"],
    dateFilter: DateTime.parse(json["dateFilter"]),
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "currency": currency,
    "movementType": movementType,
    "transactionReference": transactionReference,
    "paymentReference": paymentReference,
    "narration": narration,
    "transactionStatus": transactionStatus,
    "date": date,
    "dateFilter": dateFilter.toIso8601String(),
  };
}