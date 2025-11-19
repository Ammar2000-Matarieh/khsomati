class ProductModel {
  String? id;
  String? storeId;
  String? name;
  String? description;
  String? price;
  String? imageUrl;

  ProductModel({
    this.id,
    this.storeId,
    this.name,
    this.description,
    this.price,
    this.imageUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      storeId: json['storeId'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'storeId': storeId,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}
