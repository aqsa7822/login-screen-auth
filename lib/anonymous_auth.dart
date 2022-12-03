import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_screen/utils.dart';
class AnonymousLogin{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  Future signInAnon() async{
    try{
      User? user=(await _auth.signInAnonymously()).user;
    }
    catch(error){
      print("signin failed");
      Utils().toastMessage(error.toString());
    }
  }
}


