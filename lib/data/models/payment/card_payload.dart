class CardPayload {
  CardPayload({
    this.pbfPubKey,
    this.amount,
    this.country,
    this.currency,
    this.customLogo,
    this.customerEmail,
    this.customerFirstname,
    this.customerLastname,
    this.customerPhone,
    this.paymentoptions,
    this.txref,
    this.integrityHash,
  });

  String pbfPubKey;
  String amount;
  String country;
  String currency;
  String customLogo;
  String customerEmail;
  String customerFirstname;
  String customerLastname;
  String customerPhone;
  String paymentoptions;
  String txref;
  String integrityHash;

  factory CardPayload.fromJson(Map<String, dynamic> json) => CardPayload(
    pbfPubKey: json["PBFPubKey"],
    amount: json["amount"],
    country: json["country"],
    currency: json["currency"],
    customLogo: json["custom_logo"],
    customerEmail: json["customer_email"],
    customerFirstname: json["customer_firstname"],
    customerLastname: json["customer_lastname"],
    customerPhone: json["customer_phone"],
    paymentoptions: json["paymentoptions"],
    txref: json["txref"],
    integrityHash: json["integrity_hash"],
  );

  Map<String, dynamic> toJson() => {
    "PBFPubKey": pbfPubKey,
    "amount": amount,
    "country": country,
    "currency": currency,
    "custom_logo": customLogo,
    "customer_email": customerEmail,
    "customer_firstname": customerFirstname,
    "customer_lastname": customerLastname,
    "customer_phone": customerPhone,
    "paymentoptions": paymentoptions,
    "txref": txref,
    "integrity_hash": integrityHash,
  };
}