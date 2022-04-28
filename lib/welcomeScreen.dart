import 'package:flutter/material.dart';
import 'package:onboarding/constants.dart' as constants;
import 'package:onboarding/login_screen.dart';
import 'package:onboarding/onBoardingScreen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(117, 64, 237, 1),
        title: const Text("MY PORTAL"),
        centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor: constants.color,
        child: ListView(
          padding: const EdgeInsets.only(left: 30, top: 20, right: 30),
          children: [
            SizedBox(
              height: 50,
              // margin: EdgeInsets.symmetric(vertical: 10),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
                child: const Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 18, fontFamily: "Raleway", color: Colors.white),
                ),
                style: const ButtonStyle(
                  alignment: Alignment.centerLeft,
                ),
              ),
            ),
            SizedBox(
              height: 50,
              // margin: EdgeInsets.symmetric(vertical: 10),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OnBoardingScreen()));
                },
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                      fontSize: 18, fontFamily: "Raleway", color: Colors.white),
                ),
                style: const ButtonStyle(
                  alignment: Alignment.centerLeft,
                ),
              ),
            ),
            SizedBox(
              height: 50,
              // margin: EdgeInsets.symmetric(vertical: 10),
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Help",
                  style: TextStyle(
                      fontSize: 18, fontFamily: "Raleway", color: Colors.white),
                ),
                style: const ButtonStyle(
                  alignment: Alignment.centerLeft,
                ),
              ),
            ),
            SizedBox(
              height: 50,
              // margin: EdgeInsets.symmetric(vertical: 10),
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "About",
                  style: TextStyle(
                      fontSize: 18, fontFamily: "Raleway", color: Colors.white),
                ),
                style: const ButtonStyle(
                  alignment: Alignment.centerLeft,
                ),
              ),
            ),
            SizedBox(
              height: 50,
              // margin: EdgeInsets.symmetric(vertical: 10),
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Exit",
                  style: TextStyle(
                      fontSize: 18, fontFamily: "Raleway", color: Colors.white),
                ),
                style: const ButtonStyle(
                  alignment: Alignment.centerLeft,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Stack(children: [
        SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    constants.color,
                    Colors.white60,
                  ],
                )),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Column(children: <Widget>[
                        Image(
                          image: AssetImage("assets/course_100px.png"),
                          width: MediaQuery.of(context).size.height * 0.2,
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),
                        const Text(
                          "MY PORTAL",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontFamily: "Raleway"),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        )
                      ]),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 50,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.pinkAccent,
                          borderRadius: BorderRadius.circular(20)),
                      child: TextButton(
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: "Raleway"),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.pinkAccent,
                          borderRadius: BorderRadius.circular(20)),
                      child: TextButton(
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: "Raleway"),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const OnBoardingScreen()));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
