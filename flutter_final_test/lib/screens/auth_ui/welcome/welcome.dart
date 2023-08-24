import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_test/constants/assets_images.dart';
import 'package:flutter_final_test/screens/auth_ui/login/login.dart';
import 'package:flutter_final_test/screens/auth_ui/signup/signup.dart';
import 'package:flutter_final_test/widgets/primary_buttons.dart';
import 'package:flutter_final_test/widgets/top_title.dart';

import '../../../constants/routes.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopTitle(
                  title: 'Chào mừng', subtitle: 'Mua mọi thứ khi sử dụng App'),
              Center(child: Image.asset(AssetsImages.instance.welcomeImage)),
              
              SizedBox(
                height: 30,
              ),
              PrimaryButton(
                title: "Đăng nhập",
                onPressed: () {
                  Routes.instance.push(widget: const Login(), context: context);
                },
              ),
              SizedBox(
                height: 18,
              ),
              PrimaryButton(
                title: "Đăng ký",
                onPressed: () {
                  Routes.instance.push(widget: const SignUp(), context: context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
