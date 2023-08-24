import 'dart:convert';

import 'package:flutter_final_test/models/product_model.dart';


class OrderModel {
  OrderModel({
    required this.orderId,
    required this.payment,
    required this.products,
    required this.totalPrice,
    required this.status,
  });

  String payment;
  String status;
  List<ProductModel> products;
  String orderId;
  double totalPrice;

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> productMap = json['products'];
    return OrderModel(
      orderId: json['orderId'],
      payment: json['payment'],
      products: productMap.map((e) => ProductModel.fromJson(e)).toList(),
      totalPrice: json['totalPrice'],
      status: json['status'],
    );
  }
}
