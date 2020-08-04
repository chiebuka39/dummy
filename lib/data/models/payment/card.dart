class PaymentCard{
  int id;

  String cardType;
  String expiryDate;
  String cardName;
  String mp;
  bool isActive;

  PaymentCard({this.id, this.cardName, this.cardType,
    this.expiryDate, this.isActive, this.mp});

  static PaymentCard fromJson(Map<String, dynamic> map) {
    return PaymentCard(
      id: map['id'] ?? 0,
      cardType: map['cardType'] ?? '',
      cardName: map['cardName'] ?? '',
      mp: map['mp'] ?? '',
      isActive: map['isActive'] ?? '',
      expiryDate: map['expiryDate'] ?? '',
    );
  }

}