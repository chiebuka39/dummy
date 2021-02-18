class SavingPlanModel {
  SavingPlanModel({
    this.id,
    this.productId,
    this.productName,
    this.planName,
    this.savingsType,
    this.savingsFrequency,
    this.savingsFrequencyText,
    this.savingsAmount,
    this.targetAmount,
    this.startDate,
    this.maturityDate,
    this.status,
    this.statusText,
    this.isMatured,
    this.amountSaved,
    this.accruedInterest,
    this.interestRate,
    this.successRate,
    this.dateCreated,
    this.dateUpdated,
    this.isPaused,
    this.savingsActivities,
    this.cardId,
    this.fundingChannel,this.fundingChannelText
  });

  int id;
  int productId;
  String productName;
  String planName;
  int savingsType;
  int savingsFrequency;
  String savingsFrequencyText;
  double savingsAmount;
  double targetAmount;
  DateTime startDate;
  DateTime maturityDate;
  int status;
  String statusText;
  String fundingChannelText;
  int fundingChannel;
  int cardId;
  bool isMatured;
  double amountSaved;
  double accruedInterest;
  double interestRate;
  String successRate;
  DateTime dateCreated;
  DateTime dateUpdated;
  bool isPaused;
  dynamic savingsActivities;

  factory SavingPlanModel.fromJson(Map<String, dynamic> json) =>
      SavingPlanModel(
        id: json["id"],
        productId: json["productId"],
        productName: json["productName"],
        planName: json["planName"],
        savingsType: json["savingsType"],
        interestRate: json["interestRate"],
        savingsFrequency: json["savingsFrequency"],
        savingsFrequencyText: json["savingsFrequencyText"],
        savingsAmount: json["savingsAmount"] == null ? 0.0: double.parse(json["savingsAmount"].toString()),
        targetAmount: json["targetAmount"] == null ? 0.0: double.parse("${json["targetAmount"]}"),
        startDate: DateTime.parse(json["startDate"]),
        maturityDate: json["maturityDate"] == null
            ? null
            : DateTime.parse(json["maturityDate"]),
        status: json["status"],
        statusText: json["statusText"],
        isMatured: json["isMatured"],
        amountSaved: json["amountSaved"]  == null ? 0.0: double.parse(json["amountSaved"].toString()),
        accruedInterest: json["accruedInterest"]== null ? 0.0: double.parse(json["accruedInterest"].toString()),
        successRate: json["successRate"],
        dateCreated: DateTime.parse(json["dateCreated"]),
        dateUpdated: DateTime.parse(json["dateUpdated"]),
        isPaused: json["isPaused"],
        fundingChannel: json["fundingChannel"],
        fundingChannelText: json["fundingChannelText"],
        cardId: json["cardId"],
        //savingsActivities: json["savingsActivities"],
      );
}
