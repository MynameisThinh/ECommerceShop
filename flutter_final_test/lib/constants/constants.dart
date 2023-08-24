import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void ShowMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16);
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Builder(builder: (context) {
      return SizedBox(
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: Colors.grey,
            ),
            SizedBox(
              height: 18,
            ),
            Container(
              margin: EdgeInsets.only(left: 7),
              child: Text("Đang tải"),
            )
          ],
        ),
      );
    }),
  );
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
}

String getMessageFromErrorCode(String errorCode) {
  switch (errorCode) {
    case "ERROR_EMAIL_ALREADY_IN_USE":
      return "Email đã được sử dụng. Đến trang login page";
    case "account-exists-with-different-credential":
      return "Email đã được sử dụng. Đến trang login page";
    case "email-already-in-use":
      return "Email đã được sử dụng. Đến trang login page";
    case "ERROR_WRONG_PASSWORD":
    case "wrong-password":
      return "Sai mật khẩu";
    case "ERROR_USER_NOT_FOUND":
      return "Không tìm thấy người dùng email này";
    case "user-not-found":
      return "Không tìm thấy người dùng email này";
    case "ERROR_USER_DISABLED":
      return "User không tồn tại";
    case "user-disabled":
      return "User không tồn tại";
    case "ERROR_TOO_MANY_REQUESTED":
      return "Quá nhiều requested để đăng nhập vào tài khoản";
    case "operation-not-allowed":
      return "Quá nhiều requested để đăng nhập vào tài khoản";
    case "ERROR_OPERATION_NOT_ALLOW":
      return "Quá nhiều requested để đăng nhập vào tài khoản";
    case "ERROR_INVALID_EMAIL":
      return "Email không hợp lệ";
    case "invalid-email":
      return "Email không hợp lệ";
    default:
      return "Đăng nhập thất bại. Hãy thử lại";
  }
}

bool loginValidation(String email, String password) {
  if (email.isEmpty && password.isEmpty) {
    ShowMessage("Email và Password bị trống ");
    return false;
  }
  else if (email.isEmpty) {
    ShowMessage("Email bị trống");
    return false;
  }
  else if (password.isEmpty) {
    ShowMessage("Password bị trống");
    return false;
  } else {
    return true;
  }
}


bool signUpValidation(String email, String password,String name,String phone) {
  if (email.isEmpty && password.isEmpty && name.isEmpty && phone.isEmpty) {
    ShowMessage("Tất cả các field đều bị trống ");
    return false;
  }
  else if (email.isEmpty) {
    ShowMessage("Email bị trống");
    return false;
  }
  else if (password.isEmpty) {
    ShowMessage("Password bị trống");
    return false;
  }
   else if (name.isEmpty) {
    ShowMessage("name bị trống");
    return false;
  }
   else if (phone.isEmpty) {
    ShowMessage("phone bị trống");
    return false;
  } else {
    return true;
  }
}