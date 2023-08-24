import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_test/constants/constants.dart';
import 'package:flutter_final_test/firebase_helper/firebase_firestore/firebase_firestore_helper.dart';
import 'package:flutter_final_test/firebase_helper/firebase_storage/firebase_storage.dart';
import 'package:flutter_final_test/models/user_model.dart';

import '../models/product_model.dart';

class AppProvider with ChangeNotifier {
  bool isDarkModeOn = false;
  //Giỏ hàng
  final List<ProductModel> _cartProductList = [];
  final List<ProductModel> _buyProductList = [];

  UserModel? _userModel;

  UserModel get getUserInformation => _userModel!;

  void addCartProduct(ProductModel productModel) {
    _cartProductList.add(productModel);
    notifyListeners();
  }

  void removeCartProduct(ProductModel productModel) {
    _cartProductList.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get getCartProductList => _cartProductList;

  //isFavorite

  final List<ProductModel> _favoriteProductList = [];

  void addFavoriteProduct(ProductModel productModel) {
    _favoriteProductList.add(productModel);
    notifyListeners();
  }

  void removeFavoriteProduct(ProductModel productModel) {
    _favoriteProductList.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get getFavoriteProductList => _favoriteProductList;

  // void getUserInfoFirebase() async {
  //   _userModel = await FirebaseFireStoreHelper.instance.getUserInformation();
  //   notifyListeners();
  // }

  void updateUserInfoFirebase(
      BuildContext context, UserModel userModel, File file) async {
    showLoaderDialog(context);
    // ignore: unnecessary_null_comparison
    if (file == null) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(userModel.uid)
          .set(userModel.toMap());
    } else {
      String imageUrl =
          await FireBaseStorageHelper.instance.uploadUserImage(file);
      _userModel = userModel.copyWith(image: imageUrl);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_userModel!.uid)
          .set(_userModel!.toMap());
      notifyListeners();
    }
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }
  //user

  //Thanh toan

  double totalPrice() {
    double totalPrice = 0.0;
    for (var element in _cartProductList) {
      totalPrice += element.price * element.qty!;
    }
    return totalPrice;
  }

  double totalPriceBuyProductList() {
    double totalPrice = 0.0;
    for (var element in _buyProductList) {
      totalPrice += element.price * element.qty!;
    }
    return totalPrice;
  }

  void updateQty(ProductModel productModel, int qty) {
    int index = _cartProductList.indexOf(productModel);
    _cartProductList[index].qty = qty;
    notifyListeners();
  }

  // Mua hàng
  void addBuyProducts(ProductModel model) {
    _buyProductList.add(model);
    notifyListeners();
  }

  void addBuyProductsCartList() {
    _buyProductList.addAll(_cartProductList);
    notifyListeners();
  }

  void clearCart() {
    _cartProductList.clear();
    notifyListeners();
  }

  void clearBuyProduct() {
    _buyProductList.clear();
    notifyListeners();
  }

  List<ProductModel> get getBuyProductList => _buyProductList;

  void toggleTheme() {
    isDarkModeOn = !isDarkModeOn;
    notifyListeners();
  }
}
