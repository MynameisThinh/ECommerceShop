import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_test/account/article.dart';
import 'package:flutter_final_test/account/change_password.dart';
import 'package:flutter_final_test/account/edit_profile.dart';
import 'package:flutter_final_test/chat/customer_chat.dart';
import 'package:flutter_final_test/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:flutter_final_test/firebase_helper/firebase_firestore/firebase_firestore_helper.dart';
import 'package:flutter_final_test/models/user_model.dart';
import 'package:flutter_final_test/order/order_screen.dart';
import 'package:flutter_final_test/screens/auth_ui/welcome/welcome.dart';
import 'package:flutter_final_test/widgets/primary_buttons.dart';
import 'package:provider/provider.dart';

import '../constants/routes.dart';
import '../favorite/favorite_screen.dart';
import '../provider/app_provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          "Tài khoản",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(     
              flex: 1,
                child: Column(
                  children: [
                    Icon(
                      Icons.person_outlined,
                      size: 120,
                    ),
                   
                    Text(
                      "${loggedInUser.firstName} ${loggedInUser.secondName}",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${loggedInUser.email}",
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                        width: 120,
                        child: PrimaryButton(
                          title: "Chỉnh sửa",
                          onPressed: () {
                            Routes.instance
                                .push(widget: EditProfile(), context: context);
                          },
                        ))
                  ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Routes.instance
                            .push(widget: OrderScreen(), context: context);
                      },
                      leading: Icon(Icons.shopping_bag_outlined),
                      title: Text("Đơn hàng của bạn"),
                    ),
                    ListTile(
                      onTap: () {
                        Routes.instance
                            .push(widget: FavoriteScreen(), context: context);
                      },
                      leading: Icon(Icons.favorite_outlined),
                      title: Text("Danh sách của bạn"),
                    ),
                    ListTile(
                      onTap: () {
                        Routes.instance
                            .push(widget: Article(), context: context);
                      },
                      leading: Icon(Icons.info_outlined),
                      title: Text("Về chúng tôi"),
                    ),
                    ListTile(
                      onTap: () {
                        Routes.instance
                            .push(widget: CustomerChat(), context: context);
                      },
                      leading: Icon(Icons.support_outlined),
                      title: Text("Hỗ trợ"),
                    ),
                    ListTile(
                      onTap: () {
                        Routes.instance
                            .push(widget: ChangePassword(), context: context);
                      },
                      leading: Icon(Icons.change_circle_outlined),
                      title: Text("Đổi mật khẩu"),
                    ),
                    ListTile(
                      onTap: () {
                        logOut(context);
                      },
                      leading: Icon(Icons.exit_to_app_outlined),
                      title: Text("Đăng xuất"),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text("Version 1.0.0")
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> logOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Welcome()));
  }
}
