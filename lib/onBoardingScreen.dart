import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onboarding/homepage.dart';
import 'constants.dart' as Const;

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  Color color = const Color.fromRGBO(117, 64, 237, 1);

  FirebaseAuth auth = FirebaseAuth.instance;

  String imageUrl = "assets/";

  final keys = GlobalKey<FormState>();

  TextEditingController _fname = TextEditingController();
  TextEditingController _lname = TextEditingController();
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
        title: const Text("Sign Up"),
        centerTitle: true,
        backgroundColor: color,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height,
              decoration: Const.boxDecoration),
          Center(
            // child: Image(image: AssetImage("chef.png")),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: SingleChildScrollView(
                child: Form(
                  key: keys,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 80,
                        width: 300,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          "MY PORTAL",
                          style: TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                              fontFamily: "Raleway",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Text(
                        "First Name",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Raleway",
                        ),
                        textAlign: TextAlign.left,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: "First Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                gapPadding: 3.0)),
                        controller: _fname,
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
                          "Last Name",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Raleway",
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: "Last Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                gapPadding: 3.0)),
                        controller: _lname,
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
                            borderRadius: BorderRadiusDirectional.circular(10),
                            color: Colors.pinkAccent,
                          ),
                          child: TextButton(
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () async {
                              if (keys.currentState!.validate()) {
                                try {
                                  await auth
                                      .createUserWithEmailAndPassword(
                                        email: _email.text,
                                        password: _pass.value.toString(),
                                      )
                                      .then((value) => {
                                            auth.currentUser!.updateDisplayName(
                                                _fname.text + " " + _lname.text)
                                          });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Registration Successful'),
                                      duration: Duration(seconds: 3),
                                      elevation: 5,
                                    ),
                                  );
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomePage()));
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'weak-password') {
                                    showDialog(
                                        context: context,
                                        builder: (ctx) => const AlertDialog(
                                            title: Text(' Sign-up Failed'),
                                            content: Text(
                                                "The password is too week")));
                                  } else if (e.code == 'email-already-in-use') {
                                    showDialog(
                                        context: context,
                                        builder: (ctx) => const AlertDialog(
                                            title: Text(' Sign-up Failed'),
                                            content: Text(
                                                "The account already exists for that email")));
                                  }
                                }
                              }
                            },
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
}
