import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_screen/anonymous_auth.dart';
import 'package:login_screen/google_signin.dart';
import 'package:login_screen/home_page.dart';
import 'package:login_screen/main.dart';
import 'package:login_screen/phone_auth.dart';
import 'package:login_screen/signup.dart';
import 'package:login_screen/utils.dart';
import 'package:wc_form_validators/wc_form_validators.dart';
import 'package:login_screen/signin.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AnonymousLogin anonLogin = AnonymousLogin();
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  signIn() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: email.text.trim(), password: password.text.trim())
        .then((value) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => (const HomePage())));
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
    });
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Login In"),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        "Sign In",
                        style: TextStyle(fontSize: 32),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      validator: Validators.compose([
                        Validators.required("Email is required"),
                        Validators.email("Invalid Email Address.")
                      ]),
                      controller: email,
                      decoration: const InputDecoration(
                        labelText: "Email",
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: true,
                      validator: Validators.compose(
                          [Validators.required("Password is required")]),
                      controller: password,
                      decoration: const InputDecoration(
                        labelText: "Password",
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      // onPressed: signIn,
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          signIn();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }
                      },
                      child: const Text('Sign In'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => (const SignUp())));
                            },
                            child: const Text("Sign up"))
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => (const PhoneAuth())));
                        },
                        child: Text("Sign In with Phone Number")),
                    SizedBox(
                      height: 40,
                    ),
                    TextButton(
                        onPressed: () async {
                          dynamic result = await anonLogin.signInAnon();
                          print(result);
                          if (result != null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          } else {
                            debugPrint("Unsuccessful Anonymous Login");
                          }
                        },
                        child: Text("Sign In Anonymously")),
                    SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      // onPressed: signIn,
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.

                        signInWithGoogle();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      },
                      child: const Text('Sign In with Google'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
