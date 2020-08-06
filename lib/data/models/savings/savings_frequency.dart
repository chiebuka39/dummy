class SavingsFrequency{
  SavingsFrequency({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory SavingsFrequency.fromJson(Map<String, dynamic> json) => SavingsFrequency(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}