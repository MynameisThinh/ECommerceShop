import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../firebase_helper/firebase_firestore/firebase_firestore_helper.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';
import '../product_details.dart/product_details.dart';

class CategoryView extends StatefulWidget {
  final CategoryModel categoryModel;
  const CategoryView({super.key, required this.categoryModel});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<ProductModel> productModelList = [];

  bool isLoading = false;
  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    productModelList = await FirebaseFireStoreHelper.instance
        .getCategoryViewProduct(widget.categoryModel.id);
    productModelList.shuffle();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getCategoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? Center(
                child: Container(
                  height: 100,
                  width: 100,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: kToolbarHeight * 1,
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const BackButton(),
                          Center(
                            child: Text(
                              widget.categoryModel.name,
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(12.0),
                    //   child: Title(
                    //       color: Colors.black,
                    //       child: Text(widget.categoryModel.name)),
                    // ),
                    productModelList.isEmpty
                        ? Center(
                            child: Text("Best Product is empty"),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: GridView.builder(
                                primary: false,
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: productModelList.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 15,
                                        childAspectRatio: 0.8,
                                        crossAxisSpacing: 5),
                                itemBuilder: (context, index) {
                                  ProductModel singleProduct =
                                      productModelList[index];
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      children: [
                                        Image.network(
                                          singleProduct.image,
                                          height: 103,
                                          width: 150,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          singleProduct.name,
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text('Giá: ${singleProduct.price} VND'),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                          height: 35,
                                          width: 80,
                                          child: OutlinedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProductDetails(
                                                                singleProduct:
                                                                    singleProduct)));
                                              },
                                              style: OutlinedButton.styleFrom(
                                                  foregroundColor: Colors.grey,
                                                  surfaceTintColor: Colors.grey,
                                                  shadowColor: Colors.grey,
                                                  side: BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.7,
                                                  )),
                                              child: Text(
                                                "Mua",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          ),
                    SizedBox(
                      height: 12,
                    )
                  ],
                ),
              ));
  }
}
