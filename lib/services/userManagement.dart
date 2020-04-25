import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_project/HomePage.dart';

class UserManagement {
  final _firebaseInstance = Firestore.instance;

  storeNewUser(userData) {

    _firebaseInstance.collection('/USERS').add({
      'Email': userData.email,
      "UID": userData.uid,
    }).then((value) {
          print(value);
    });

  }
}