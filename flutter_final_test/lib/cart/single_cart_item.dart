import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../models/product_model.dart';
import '../provider/app_provider.dart';

class SingleCartItem extends StatefulWidget {
  final ProductModel singleProduct;
  const SingleCartItem({super.key, required this.singleProduct});

  @override
  State<SingleCartItem> createState() => _SingleCartItemState();
}

class _SingleCartItemState extends State<SingleCartItem> {
  int qty = 1;
  @override
  void initState() {
    qty = widget.singleProduct.qty ?? 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey, width: 1.3)),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 160,
              // color: Colors.grey.withOpacity(3),
              child: Image.network(widget.singleProduct.image),
            ),
          ),
          Expanded(
              flex: 2,
              child: SizedBox(
                height: 160,
                child: Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 35, right: 10, top: 19),
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                FittedBox(
                                  child: Text(
                                    widget.singleProduct.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${widget.singleProduct.price.toString()}VND',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    CupertinoButton(
                                      onPressed: () {
                                        if (qty > 1) {
                                          setState(() {
                                            qty--;
                                          });
                                          appProvider.updateQty(
                                              widget.singleProduct, qty);
                                        }
                                      },
                                      padding: EdgeInsets.zero,
                                      child: CircleAvatar(
                                        maxRadius: 13,
                                        child: Icon(Icons.remove),
                                      ),
                                    ),
                                    Text(
                                      qty.toString(),
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    CupertinoButton(
                                      onPressed: () {
                                        setState(() {
                                          qty++;
                                        });
                                        appProvider.updateQty(
                                            widget.singleProduct, qty);
                                      },
                                      padding: EdgeInsets.zero,
                                      child: CircleAvatar(
                                        maxRadius: 13,
                                        child: Icon(Icons.add),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CupertinoButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        if (!appProvider.getFavoriteProductList
                                            .contains(widget.singleProduct)) {
                                          appProvider.addFavoriteProduct(
                                              widget.singleProduct);
                                          ShowMessage("Thêm vào danh sách");
                                        } else {
                                          appProvider.removeFavoriteProduct(
                                              widget.singleProduct);
                                          ShowMessage("Xóa khỏi danh sách");
                                        }
                                      },
                                      child: Text(
                                        appProvider.getFavoriteProductList
                                                .contains(widget.singleProduct)
                                            ? "Xóa khỏi danh sách"
                                            : "Thêm vào danh sách",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    CupertinoButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          appProvider.removeCartProduct(
                                              widget.singleProduct);
                                          ShowMessage('Xóa khỏi giỏ hàng');
                                        },
                                        child: CircleAvatar(
                                          maxRadius: 13,
                                          child: Icon(
                                            Icons.delete,
                                            size: 12,
                                          ),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
