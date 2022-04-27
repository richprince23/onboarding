import 'package:flutter/material.dart';
import 'package:onboarding/constants.dart' as constants;
import 'package:onboarding/homepage.dart';
// import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth_oauth/firebase_auth_oauth.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Color color = const Color.fromRGBO(117, 64, 237, 1);
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false;
  String imageUrl = "assets/";

  final keys = GlobalKey<FormState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Log In"),
        centerTitle: true,
        backgroundColor: color,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height,
              decoration: constants.boxDecoration),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: SingleChildScrollView(
                child: Form(
                  key: keys,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Container(
                      //   height: 80,
                      //   width: 300,
                      //   alignment: Alignment.center,
                      //   padding: const EdgeInsets.all(10),
                      //   child: const Text(
                      //     "MY PORTAL",
                      //     style: TextStyle(
                      //         fontSize: 28,
                      //         color: Colors.white,
                      //         fontFamily: "Raleway",
                      //         fontWeight: FontWeight.bold),
                      //   ),
                      // ),
                      Container(
                        padding: const EdgeInsets.only(top: 20),
                        child: const Text(
                          "Email",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Raleway",
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: "Email Address",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                gapPadding: 3.0)),
                        controller: _email,
                        validator: (value) {
                          if (value == "") {
                            return "Please fill this field";
                          } else {
                            return null;
                          }
                        },
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 20),
                        child: const Text(
                          "Password",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Raleway",
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: "Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                gapPadding: 3.0)),
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        controller: _pass,
                        validator: (value) {
                          if (value == "") {
                            return "Please fill this field";
                          } else {
                            return null;
                          }
                        },
                      ),
                      Container(
                          // padding: const EdgeInsets.symmetric(
                          //     vertical: 10, horizontal: 10),
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 50,
                          // alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(20),
                            color: Colors.pinkAccent,
                          ),
                          child: Center(
                            child: TextButton(
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () async {
                                  if (keys.currentState!.validate()) {
                                    // Future<void> login() async {
                                    // setState(() {
                                    //   isLoading = true;
                                    // });
                                    showLoadDialog(context);
                                    try {
                                      await auth
                                          .signInWithEmailAndPassword(
                                              email: _email.text,
                                              password: _pass.value.toString())
                                          .then((value) => {
                                                Navigator.popAndPushNamed(
                                                    context, '/home')
                                              });
                                    } on FirebaseAuthException catch (e) {
                                      if (e.code == 'user-not-found') {
                                        showDialog(
                                            context: context,
                                            builder: (ctx) => const AlertDialog(
                                                title: Text(' Login-in Failed'),
                                                content:
                                                    Text("User not found")));
                                      } else if (e.code == 'wrong-password') {
                                        showDialog(
                                            context: context,
                                            builder: (ctx) => const AlertDialog(
                                                title: Text(' Login-in Failed'),
                                                content: Text(
                                                    "Incorrect password")));
                                      }
                                    }
                                  }
                                }),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  showLoadDialog(BuildContext context) {
    //set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        child: Center(
          child: const CircularProgressIndicator(),
        ),
      ),
    );
    showDialog(
      //prevent outside touch
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        //prevent Back button press
        return alert;
      },
    );
  }
}
