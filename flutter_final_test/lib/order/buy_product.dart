import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_test/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:flutter_final_test/firebase_helper/firebase_firestore/firebase_firestore_helper.dart';
import 'package:flutter_final_test/models/product_model.dart';
import 'package:flutter_final_test/provider/app_provider.dart';
import 'package:flutter_final_test/widgets/primary_buttons.dart';
import 'package:provider/provider.dart';

import '../constants/routes.dart';

class BuyProduct extends StatefulWidget {
  final ProductModel singleProduct;
  const BuyProduct({super.key, required this.singleProduct});

  @override
  State<BuyProduct> createState() => _BuyProductState();
}

class _BuyProductState extends State<BuyProduct> {
  int groupValue = 1;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Thanh toán",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(
              height: 36,
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border:
                    Border.all(color: Theme.of(context).primaryColor, width: 2),
              ),
              width: double.infinity,
              child: Row(
                children: [
                  Radio(
                      value: 1,
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value!;
                        });
                      }),
                  const Icon(Icons.money),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    "Thanh toán trực tiếp",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border:
                    Border.all(color: Theme.of(context).primaryColor, width: 2),
              ),
              width: double.infinity,
              child: Row(
                children: [
                  Radio(
                      value: 2,
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value!;
                        });
                      }),
                  const Icon(Icons.money),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    "Thanh toán online",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            PrimaryButton(
              title: "Tiếp tục",
              onPressed: () async {
                appProvider.clearBuyProduct();
                appProvider.addBuyProducts(widget.singleProduct);
                bool value = await FirebaseFireStoreHelper.instance
                    .uploadOrderedProductFirebase(
                        appProvider.getBuyProductList,
                        context,
                        groupValue == 1 ? "Thanh toán trực tiếp" : "Thanh toán qua visa");
                if (value) {
                  Future.delayed(Duration(seconds: 2), () {
                    Routes.instance
                        .push(widget: CustomBottomBar(), context: context);
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
