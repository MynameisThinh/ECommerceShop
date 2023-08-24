import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_test/firebase_helper/firebase_storage/firebase_storage.dart';
import 'package:flutter_final_test/provider/app_provider.dart';
import 'package:flutter_final_test/widgets/primary_buttons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  File? image;
  void takePicture() async {
    XFile? value = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 40);
    if (value != null) {
      setState(() {
        image = File(value.path);
      });
    }
  }

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

  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Cá nhân",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          image == null
              ? CupertinoButton(
                  onPressed: () {
                    takePicture();
                  },
                  child:
                      CircleAvatar(radius: 70, child: Icon(Icons.camera_alt)),
                )
              : CupertinoButton(
                  onPressed: () {
                    takePicture();
                  },
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: FileImage(image!),
                  ),
                ),
          SizedBox(
            height: 12,
          ),
          TextFormField(
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: "${loggedInUser.firstName} ${loggedInUser.secondName}",
            ),
          ),
          SizedBox(
            height: 12,
          ),
          PrimaryButton(
            title: "Cập nhật",
            onPressed: () async {
              UserModel userModel = appProvider.getUserInformation
                  .copyWith(secondName: textEditingController);
              appProvider.updateUserInfoFirebase(context, userModel, image!);
            },
          )
        ],
      ),
    );
  }
}
