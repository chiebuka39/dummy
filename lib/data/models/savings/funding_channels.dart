class FundingChannel{
  FundingChannel({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory FundingChannel.fromJson(Map<String, dynamic> json) => FundingChannel(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}