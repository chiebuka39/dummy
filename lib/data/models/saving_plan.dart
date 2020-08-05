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
    this.successRate,
    this.dateCreated,
    this.dateUpdated,
    this.isPaused,
    this.savingsActivities,
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
  bool isMatured;
  double amountSaved;
  double accruedInterest;
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
        savingsFrequency: json["savingsFrequency"],
        savingsFrequencyText: json["savingsFrequencyText"],
        savingsAmount: json["savingsAmount"],
        targetAmount: json["targetAmount"] == null ? 0.0: double.parse("${json["targetAmount"]}"),
        startDate: DateTime.parse(json["startDate"]),
        maturityDate: json["maturityDate"] == null
            ? null
            : DateTime.parse(json["maturityDate"]),
        status: json["status"],
        statusText: json["statusText"],
        isMatured: json["isMatured"],
        amountSaved: json["amountSaved"],
        accruedInterest: json["accruedInterest"].toDouble(),
        successRate: json["successRate"],
        dateCreated: DateTime.parse(json["dateCreated"]),
        dateUpdated: DateTime.parse(json["dateUpdated"]),
        isPaused: json["isPaused"],
        //savingsActivities: json["savingsActivities"],
      );
}
