class Asset {
  Asset({
    this.id,
    this.assetLiabilityType,
    this.assetLiabilityTypeName,
    this.assetLiabilityName,
  });

  int id;
  int assetLiabilityType;
  String assetLiabilityTypeName;
  String assetLiabilityName;

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
    id: json["id"],
    assetLiabilityType: json["assetLiabilityType"],
    assetLiabilityTypeName: json["assetLiabilityTypeName"],
    assetLiabilityName: json["assetLiabilityName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "assetLiabilityType": assetLiabilityType,
    "assetLiabilityTypeName": assetLiabilityTypeName,
    "assetLiabilityName": assetLiabilityName,
  };
}