import 'package:flutter/material.dart';
import 'package:login_screen/otp_page.dart';
import 'package:pinput/pinput.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({Key? key}) : super(key: key);

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign in with Phone Number"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Text(
                  "Enter your Phone Number",
                  style: TextStyle(
                    fontSize: 26,
                  ),
                )),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    validator: Validators.compose(
                      [
                        Validators.required("Phone Number is requied"),
                        Validators.minLength(
                            10, "Number should be of 10 digits.")
                      ],
                    ),
                    decoration: InputDecoration(
                      hintText: "Phone Number",
                      prefix: Text("+1"),
                    ),
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    controller: _phoneController,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              OTPpage(_phoneController.text)));
                    }
                  },
                  child: Text("Next"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
