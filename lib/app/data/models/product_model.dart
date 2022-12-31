class Product {
  int? price;
  String? name;
  String? description;
  String? packageId;

  Product({this.price, this.name, this.description, this.packageId});

  Product.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    name = json['name'];
    description = json['description'];
    packageId = json['packageId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['price'] = price;
    data['name'] = name;
    data['description'] = description;
    data['packageId'] = packageId;
    return data;
  }
}
