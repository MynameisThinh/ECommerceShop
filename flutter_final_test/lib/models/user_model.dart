import 'package:firebase_auth/firebase_auth.dart';

import 'dart:convert';

class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String? image;

  UserModel({this.uid, this.email, this.firstName, this.secondName,this.image});

  //data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
      image: map['image'],
    );
  }

  //sending data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'image':image,
    };
  }

  UserModel copyWith({
    String? firstName,
    secondName,
    image,
  }) =>
      UserModel(
      uid: uid, 
      image: image ?? this.image,
      firstName: firstName ?? this.firstName,
      secondName: secondName ?? this.secondName);
      
}
