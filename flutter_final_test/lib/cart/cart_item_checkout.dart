import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_test/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:flutter_final_test/firebase_helper/firebase_firestore/firebase_firestore_helper.dart';
import 'package:flutter_final_test/provider/app_provider.dart';
import 'package:flutter_final_test/stripe_helper/stripe_helper.dart';
import 'package:flutter_final_test/widgets/primary_buttons.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_final_test/stripe_helper/stripe_helper.dart';
import 'package:provider/provider.dart';

import '../constants/routes.dart';

class CartItemCheckOut extends StatefulWidget {
  const CartItemCheckOut({super.key});

  @override
  State<CartItemCheckOut> createState() => _CartItemCheckOutState();
}

class _CartItemCheckOutState extends State<CartItemCheckOut> {
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
                if (groupValue == 1) {
                  bool value = await FirebaseFireStoreHelper.instance
                      .uploadOrderedProductFirebase(
                          appProvider.getBuyProductList,
                          context,
                          "Thanh toán tiền mặt");

                  appProvider.clearBuyProduct();
                  if (value) {
                    Future.delayed(const Duration(seconds: 2), () {
                      Routes.instance.push(
                          widget: const CustomBottomBar(), context: context);
                    });
                  }
                } else {
                 
                  int value = double.parse(
                          appProvider.totalPriceBuyProductList().toString())
                      .round()
                      .toInt();
                  String totalPrice = (value).toString();
                  await StripeHelper.instance
                      .makePayment(totalPrice.toString(), context);
                }
              },
                // bool value = await FirebaseFireStoreHelper.instance
                //     .uploadOrderedProductFirebase(
                //         appProvider.getBuyProductList,
                //         context,
                //         groupValue == 1 ? "Thanh toán trực tiếp" : "Đã trả");

                // appProvider.clearBuyProduct();
                // if (value) {
                //   Future.delayed(Duration(seconds: 2), () {
                //     Routes.instance
                //         .push(widget: CustomBottomBar(), context: context);
                //   });
                // }
            
            )
          ],
        ),
      ),
    );
  }
}
