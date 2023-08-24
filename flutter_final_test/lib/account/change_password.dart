import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_test/constants/constants.dart';
import 'package:flutter_final_test/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:flutter_final_test/widgets/primary_buttons.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isShowPassword = true;
  TextEditingController newpassword = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Đổi mật khẩu",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          TextFormField(
            controller: newpassword,
            obscureText: isShowPassword,
            decoration: InputDecoration(
                hintText: "Mật khẩu",
                prefixIcon: const Icon(Icons.password_sharp),
                suffixIcon: CupertinoButton(
                  onPressed: () {
                    setState(() {
                      isShowPassword = !isShowPassword;
                    });
                  },
                  padding: EdgeInsets.zero,
                  child: Icon(
                    Icons.visibility,
                    color: Colors.grey,
                  ),
                )),
          ),
          SizedBox(
            height: 12,
          ),
          TextFormField(
            controller: confirmpassword,
            obscureText: isShowPassword,
            decoration: InputDecoration(
                hintText: "Xác nhận mật khẩu",
                prefixIcon: const Icon(Icons.password_sharp),
                suffixIcon: CupertinoButton(
                  onPressed: () {
                    setState(() {
                      isShowPassword = !isShowPassword;
                    });
                  },
                  padding: EdgeInsets.zero,
                  child: Icon(
                    Icons.visibility,
                    color: Colors.grey,
                  ),
                )),
          ),
          SizedBox(
            height: 36,
          ),
          PrimaryButton(
            title: "Cập nhật",
            onPressed: () async {
              if (newpassword.text.isEmpty) {
                ShowMessage("Mật khẩu mới chưa nhập");
              } else if (confirmpassword.text.isEmpty) {
                ShowMessage("Mật khẩu xác nhận chưa nhập");
              }
              if (confirmpassword.text == newpassword.text) {
                FirebaseAuthHelper.instance
                    .changePassword(newpassword.text, context);
              } else {
                ShowMessage("Mật khẩu xác nhận không khớp");
              }
            },
          )
        ],
      ),
    );
  }
}
