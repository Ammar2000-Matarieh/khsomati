class StoreModel {
  String? id;
  String? userId;
  String? name;
  String? description;
  String? phone;
  String? whatsapp;
  String? mainImageUrl;
  List<String>? extraImagesUrls;

  StoreModel({
    this.id,
    this.userId,
    this.name,
    this.description,
    this.phone,
    this.whatsapp,
    this.mainImageUrl,
    this.extraImagesUrls,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
      description: json['description'],
      phone: json['phone'],
      whatsapp: json['whatsapp'],
      mainImageUrl: json['mainImageUrl'],
      extraImagesUrls: List<String>.from(json['extraImagesUrls'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId':userId,
      'name': name,
      'description': description,
      'phone': phone,
      'whatsapp': whatsapp,
      'mainImageUrl': mainImageUrl,
      'extraImagesUrls': extraImagesUrls,
    };
  }
}
