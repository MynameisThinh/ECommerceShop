import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_test/cart/cart_item_checkout.dart';
import 'package:flutter_final_test/cart/single_cart_item.dart';
import 'package:flutter_final_test/constants/constants.dart';
import 'package:flutter_final_test/order/buy_product.dart';
import 'package:provider/provider.dart';

import '../constants/routes.dart';
import '../provider/app_provider.dart';
import '../widgets/primary_buttons.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 180,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Thanh toán online",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${appProvider.totalPrice().toString()} VND",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              PrimaryButton(
                title: "Thanh toán",
                onPressed: () {
                  appProvider.clearBuyProduct();
                  appProvider.addBuyProductsCartList();
                  appProvider.clearCart();
                  if (appProvider.getBuyProductList.isEmpty) {
                    ShowMessage("Giỏ hàng trống");
                  } else {
                    Routes.instance
                        .push(widget: CartItemCheckOut(), context: context);
                  }
                },
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Giỏ hàng',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: appProvider.getCartProductList.isEmpty
          ? Center(
              child: Text("Giỏ hàng đang trống"),
            )
          : ListView.builder(
              itemCount: appProvider.getCartProductList.length,
              padding: EdgeInsets.all(12),
              itemBuilder: (context, index) {
                return SingleCartItem(
                  singleProduct: appProvider.getCartProductList[index],
                );
              }),
    );
  }
}
