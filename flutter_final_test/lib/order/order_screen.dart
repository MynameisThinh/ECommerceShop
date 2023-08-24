import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_test/firebase_helper/firebase_firestore/firebase_firestore_helper.dart';
import 'package:flutter_final_test/models/order_model.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Đơn hàng của bạn",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder(
          future: FirebaseFireStoreHelper.instance.getUserOrder(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.length,
                padding: EdgeInsets.all(12.0),
                itemBuilder: (context, index) {
                  OrderModel orderModel = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 50.0),
                    child: ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      collapsedShape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey, width: 2.3),
                      ),
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Container(
                            height: 120,
                            width: 120,
                            child: Image.network(
                              orderModel.products[0].image,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  orderModel.products[0].name,
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                orderModel.products.length > 1
                                    ? SizedBox()
                                    : Column(
                                        children: [
                                          Text(
                                            'Số lượng: ${orderModel.products[0].qty.toString()}',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                        ],
                                      ),
                                Text(
                                  'Tổng giá tiền: ${orderModel.totalPrice.toString()}VND',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  'Trạng thái đơn hàng: ${orderModel.status}',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      children: orderModel.products.length > 1
                          ? [
                              Text("Chi tiết"),
                              Divider(
                                color: Colors.grey,
                              ),
                              ...orderModel.products.map((singleProduct) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.only(left: 12, top: 6),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.baseline,
                                        textBaseline: TextBaseline.alphabetic,
                                        children: [
                                          Container(
                                            height: 120,
                                            width: 120,
                                            child: Image.network(
                                              singleProduct.image,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(12),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  singleProduct.name,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 12,
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      'Số lượng: ${singleProduct.qty.toString()}',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 12,
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  'Tổng giá tiền: ${singleProduct.price.toString()}VND',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }).toList()
                            ]
                          : [],
                    ),
                  );
                });
          }),
    );
  }
}
