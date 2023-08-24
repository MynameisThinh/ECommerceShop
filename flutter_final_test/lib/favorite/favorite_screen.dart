import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_test/favorite/single_favorite_item.dart';
import 'package:provider/provider.dart';

import '../provider/app_provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Danh sách',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: appProvider.getFavoriteProductList.isEmpty
          ? Center(
              child: Text("Danh sách đang trống"),
            )
          : ListView.builder(
              itemCount: appProvider.getFavoriteProductList.length,
              padding: EdgeInsets.all(12),
              itemBuilder: (context, index) {
                return SingleFavoriteItem(
                  singleProduct: appProvider.getFavoriteProductList[index],
                );
              }),
    );
  }
}
