import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel(
      {required this.image,
      required this.id,
      required this.name,
      required this.price,
      required this.description,
      required this.isFavorite,
      this.qty});

  String image;
  String id;
  String name;
  String description;
  double price;
  bool isFavorite;
  int? qty;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      isFavorite: false,
      qty: json['qty'],
      price: double.parse(json['price'].toString()));

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'image': image,
        'isFavorite': isFavorite,
        'price': price,
        'qty': qty,
      };
  ProductModel copyWith({
    int? qty,
  }) =>
      ProductModel(
          image: image,
          id: id,
          name: name,
          price: price,
          description: description,
          isFavorite: isFavorite,
          qty: qty??this.qty,
          );
}
