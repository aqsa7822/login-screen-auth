import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_screen/home_page.dart';
import 'package:login_screen/utils.dart';
import 'package:pinput/pinput.dart';
import 'package:login_screen/phone_auth.dart';
import '';

class OTPpage extends StatefulWidget {
  final String phone;
  OTPpage(this.phone);

  @override
  State<OTPpage> createState() => _OTPpageState();
}

class _OTPpageState extends State<OTPpage> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String? _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verifyPhone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP-Verificaation"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: Text(
                "Verify +92${widget.phone}",
                style: TextStyle(fontSize: 20),
              )),
              Padding(
                padding: EdgeInsets.all(10),
                child: Pinput(
                  length: 6,
                  controller: _pinPutController,
                  onSubmitted: (pin) async {
                    try{
                      await FirebaseAuth.instance.signInWithCredential(PhoneAuthProvider.credential(verificationId: _verificationCode!, smsCode: pin)).then((value) async{
                        if(value.user!=null){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                        }
                      });
                    }
                    catch(error){
                      Utils().toastMessage(error.toString());

                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+92${widget.phone}",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential).then((value) async{
              if(value.user !=null){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
              }
          });
        },
        verificationFailed: (FirebaseAuthException error) {
          Utils().toastMessage(error.toString());
        },
        codeSent: (String? verficationID, int? resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 10));
  }

}
