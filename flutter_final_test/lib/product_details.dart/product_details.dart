import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_final_test/constants/constants.dart';
import 'package:flutter_final_test/order/buy_product.dart';
import 'package:provider/provider.dart';

import '../cart/cart_screen.dart';
import '../constants/routes.dart';
import '../models/product_model.dart';
import '../provider/app_provider.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel singleProduct;
  const ProductDetails({super.key, required this.singleProduct});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int qty = 1;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen()));
              },
              icon: Icon(Icons.shopping_cart))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Image.network(
              widget.singleProduct.image,
              height: 300,
              width: 300,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.singleProduct.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        widget.singleProduct.isFavorite =
                            !widget.singleProduct.isFavorite;
                      });
                      if (widget.singleProduct.isFavorite) {
                        appProvider.addFavoriteProduct(widget.singleProduct);
                      } else {
                        appProvider.removeFavoriteProduct(widget.singleProduct);
                      }
                    },
                    icon: Icon(appProvider.getFavoriteProductList
                            .contains(widget.singleProduct)
                        ? Icons.favorite
                        : Icons.favorite_border))
              ],
            ),
            Text(widget.singleProduct.description),
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                CupertinoButton(
                  onPressed: () {
                    if (qty >= 1) {
                      setState(() {
                        qty--;
                      });
                    }
                  },
                  padding: EdgeInsets.zero,
                  child: CircleAvatar(
                    child: Icon(Icons.remove),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  qty.toString(),
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                CupertinoButton(
                  onPressed: () {
                    setState(() {
                      qty++;
                    });
                  },
                  child: CircleAvatar(
                    child: Icon(Icons.add),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    ProductModel productModel =
                        widget.singleProduct.copyWith(qty: qty);
                    appProvider.addCartProduct(productModel);
                    ShowMessage('Thêm vào giỏ hàng thành công');
                  },
                  child: Text('Thêm vào giỏ hàng'),
                ),
                SizedBox(
                  width: 12,
                ),
                SizedBox(
                  height: 40,
                  width: 150,
                  child: ElevatedButton(
                      onPressed: () {
                        ProductModel productModel =
                        widget.singleProduct.copyWith(qty: qty);
                        Routes.instance
                            .push(widget: BuyProduct(singleProduct: productModel,), context: context);
                      },
                      child: Text("Mua")),
                )
              ],
            ),
            SizedBox(
              height: 14,
            )
          ],
        ),
      ),
    );
  }
}
