import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_test/constants/constants.dart';

class FirebaseAuthHelper {
  static FirebaseAuthHelper instance = FirebaseAuthHelper();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<User?> get getAuthChange => _auth.authStateChanges();

  Future<bool> changePassword(String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
      _auth.currentUser!.updatePassword(password);
      // await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.of(context, rootNavigator: true).pop();
      ShowMessage("Mật khẩu đã được thay đổi");
      Navigator.of(context).pop();
      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.of(context).pop();
      ShowMessage(error.code.toString());
      return false;
    }
  }

//   Future<bool> signUp(
//       String name, String email, String password, BuildContext context) async {
//     try {
//       showLoaderDialog(context);
//       UserCredential? userCredential = await _auth
//           .createUserWithEmailAndPassword(email: email, password: password);
//       UserModel userModel = UserModel(
//           id: userCredential.user!.uid, name: name, email: email, image:);

//       _firestore.collection("user").doc(userModel.id).set(userModel.toJson());
//       Navigator.of(context).pop();
//       return true;
//     } on FirebaseAuthException catch (error) {
//       Navigator.of(context).pop();
//       ShowMessage(error.code.toString());
//       return false;
//     }
//   }

//   void signOut() async {
//     await _auth.signOut();
//   }
// }
}
