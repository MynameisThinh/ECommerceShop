import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_test/provider/app_provider.dart';
import 'package:provider/provider.dart';

import '../../category/category_view.dart';
import '../../firebase_helper/firebase_firestore/firebase_firestore_helper.dart';
import '../../models/category_model.dart';
import '../../models/product_model.dart';
import '../../product_details.dart/product_details.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categoriesList = [];
  List<ProductModel> productModelList = [];

  bool isLoading = false;
  @override
  void initState() {
    getCategoryList();
    super.initState();
  }

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    FirebaseFireStoreHelper.instance.updateTokenFromFirebase();
    categoriesList = await FirebaseFireStoreHelper.instance.getCategories();
    productModelList = await FirebaseFireStoreHelper.instance.getbestProducts();

    productModelList.shuffle();
    setState(() {
      isLoading = false;
    });
  }

  TextEditingController search = TextEditingController();
  List<ProductModel> searchList = [];
  void searchProducts(String value) {
    productModelList
        .where((element) =>
            element.name.toLowerCase() ==
            search.text.toLowerCase().contains(value.toLowerCase()))
        .toList();
    print(searchList.length);
    setState(() {});
  }

  final List<String> images = [
    'assets/images/images3.jpg',
    'assets/images/images6.jpg',
    'assets/images/images7.jpg'
  ];
  final List<String> places = ["Độc đáo", "Sáng tạo", "Thanh lịch"];

  List<Widget> generatedImages() {
    return images
        .map((element) => ClipRRect(
              child: Image.asset(
                element,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(15),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _key,
      drawer: Drawer(),
      appBar: AppBar(
        title: Text(
          "StyleShop",
          style: TextStyle(
              color: Colors.grey, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.grey[100],
        leading: IconButton(
            onPressed: () {
              Provider.of<AppProvider>(context, listen: false).toggleTheme();
            },
            icon: Icon(
              Icons.lightbulb_circle,
              color: Colors.black,
            )),
        actions: <Widget>[
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_none,
                color: Colors.black,
              )),
          Text(
            "",
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
      body: isLoading
          ? Center(
              child: Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              key: _key,
                              controller: search,
                              onChanged: (String value) {
                                searchProducts(value);
                              },
                              decoration: InputDecoration(
                                
                                hintText: "Tìm kiếm..",
                                prefixIcon: Icon(Icons.search),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Container(
                                color: Colors.white,
                                height: 120,
                                child: Stack(
                                  children: [
                                    CarouselSlider(
                                        items: generatedImages(),
                                        options: CarouselOptions(
                                          enlargeCenterPage: true,
                                          autoPlay: true,
                                          aspectRatio: 18 / 8,
                                        )),
                                    AspectRatio(
                                      aspectRatio: 18 / 8,
                                      child: Center(
                                        child: Text(
                                          '',
                                          style: TextStyle(
                                              decoration: TextDecoration.none,
                                              color: Colors.white,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  15),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            // Center(
                            //   child: Column(
                            //     children: [
                            //       AnimatedSmoothIndicator(
                            //           activeIndex: current,
                            //           count: images.length)
                            //     ],
                            //   ),
                            // ),
                            Container(
                              height: 50,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Nhãn hàng thời trang",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            categoriesList.isEmpty
                                ? Center(
                                    child: Text("Categories is empty"),
                                  )
                                : SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                        children: categoriesList
                                            .map(
                                              (e) => Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: CupertinoButton(
                                                  padding: EdgeInsets.zero,
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                CategoryView(
                                                                    categoryModel:
                                                                        e)));
                                                  },
                                                  child: Card(
                                                    color: Colors.white,
                                                    elevation: 13.0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: SizedBox(
                                                      height: 100,
                                                      width: 100,
                                                      child: Image.network(
                                                          e.image),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList()),
                                  )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Bán chạy nhất",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                buildFeaturedProduct(
                                    image: "dior.jpg", name: "Váy dài Dior"),
                                buildFeaturedProduct(
                                    image: "chanel.jpg",
                                    name: "Áo khoác Chanel"),
                                buildFeaturedProduct(
                                    image: "louis.jpg", name: "Áo phông LV"),
                                buildFeaturedProduct(
                                    image: "dolce.jpg",
                                    name: "Váy sành điệu Dolce"),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Những sản phẩm tiêu biểu",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  search.text.isNotEmpty && searchList.isEmpty
                      ? Center(
                          child: Text("Không tìm thấy sản phẩm"),
                        )
                      : searchList.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: GridView.builder(
                                  primary: false,
                                  padding: EdgeInsets.only(bottom: 50),
                                  shrinkWrap: true,
                                  itemCount: searchList.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 15,
                                          childAspectRatio: 0.8,
                                          crossAxisSpacing: 5),
                                  itemBuilder: (context, index) {
                                    ProductModel singleProduct =
                                        searchList[index];
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
                                          Text('Giá: \$${singleProduct.price}'),
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
                                                    foregroundColor:
                                                        Colors.grey,
                                                    surfaceTintColor:
                                                        Colors.grey,
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
                            )
                          : productModelList.isEmpty
                              ? const Center(
                                  child: Text("Sản phẩm đang trống"),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: GridView.builder(
                                      primary: false,
                                      padding: EdgeInsets.only(bottom: 50),
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
                                            borderRadius:
                                                BorderRadius.circular(8),
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
                                              Text(
                                                  'Giá: ${singleProduct.price} VND'),
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
                                                    style: OutlinedButton
                                                        .styleFrom(
                                                            foregroundColor:
                                                                Colors.grey,
                                                            surfaceTintColor:
                                                                Colors.grey,
                                                            shadowColor:
                                                                Colors.grey,
                                                            side: BorderSide(
                                                              color:
                                                                  Colors.grey,
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
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      Provider.of<AppProvider>(context, listen: false)
                          .toggleTheme();
                    },
                    child: Icon(Icons.lightbulb_outline),
                  )
                ],
              ),
            ),
    );
  }

  Widget buildFeaturedProduct({required String name, required String image}) {
    return Card(
      child: Container(
        height: 200,
        width: 166,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Container(
                height: 130,
                width: 120,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/$image'))),
              ),
            ),
            Text(
              name,
              style: TextStyle(fontSize: 17),
            )
          ],
        ),
      ),
    );
  }
}
