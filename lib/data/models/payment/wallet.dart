class Wallet{
  int walletNum;
  int balance;
  bool hasWallet;

  Wallet({this.balance, this.walletNum, this.hasWallet});

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
    walletNum: json["walletNumber"],
    balance: json["balance"],
  );

  Map<String, dynamic> toJson() => {
    "walletNumber": walletNum,
    "balance": balance,
  };
}