import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_final/Screens/Firestore/FireStoreScreen.dart';
import 'package:firebase_final/Screens/Login_Screen.dart';
import 'package:firebase_final/Screens/Post_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SuccessfullScreen{
  void islogin(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      Timer(
        Duration(seconds: 2),
            () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FireStoreScreen(),
            )),
      );
    } else {
      Timer(
        Duration(seconds: 2),
            () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            )),
      );
    }
  }



}