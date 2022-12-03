import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_screen/home_page.dart';
import 'package:login_screen/main.dart';
import 'package:login_screen/signin.dart';

class SplashService {
  void isLogin(BuildContext context) {
    final _auth=FirebaseAuth.instance;
    final user=_auth.currentUser;
    if(user!=null)
      {
        Timer(
            const Duration(seconds: 3),
                () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => (const HomePage()))));
      }
    else{
      Timer(
          const Duration(seconds: 3),
              () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => (const LoginPage()))));
    }

  }
}
