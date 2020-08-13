class AspireTarget {
  AspireTarget({
    this.message,
    this.requiredAmount,
  });

  String message;
  int requiredAmount;

  factory AspireTarget.fromJson(Map<String, dynamic> json) => AspireTarget(
    message: json["message"],
    requiredAmount: json["requiredAmount"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "requiredAmount": requiredAmount,
  };
}