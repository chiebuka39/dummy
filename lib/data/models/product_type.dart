class ProductType{
  int id;
  String productTypeName;

  ProductType({this.id, this.productTypeName});

  static ProductType fromJson(Map<String, dynamic> map) {
    return ProductType(
        id: map['id'] ?? 0,
        productTypeName: map['productTypeName'] ?? '',

    );
  }
}