import 'dart:io';
// import 'dart:js_util';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onboarding/cuisines_page.dart';
import 'package:onboarding/db/portal_database.dart';
// import 'package:onboarding/login_screen.dart';
import 'package:onboarding/profile.dart';
import 'app_head.dart';
import 'app_drawer.dart';
import 'constants.dart' as constants;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color color = const Color.fromRGBO(117, 64, 237, 1);

  final User? curUser = FirebaseAuth.instance.currentUser;

  TextStyle cardTextStyle = const TextStyle(
      color: Colors.black,
      fontFamily: "Raleway",
      fontSize: 14,
      fontWeight: FontWeight.w400);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // actions: [],
        elevation: 0,
        backgroundColor: color,
        title: const appHead(),
        // toolbarHeight: 50,
      ),
      // drawer: Drawer(backgroundColor: color, child: _drawer()),
      drawer: Drawer(backgroundColor: color, child: appDrawer()),
      body: Stack(
        children: <Widget>[
          // Container(
          //   height: MediaQuery.of(context).size.height * 0.2,
          //   width: MediaQuery.of(context).size.width,
          //   decoration: BoxDecoration(
          //     color: Colors.pinkAccent,
          //     image: DecorationImage(
          //         fit: BoxFit.fill,
          //         image: AssetImage("bg.jpg"),
          //         alignment: Alignment.bottomCenter),
          //   ),
          // ),
          SafeArea(
            child: Container(
              // width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              margin: const EdgeInsets.only(top: 40),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                primary: false,
                children: <Widget>[
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Profile()));
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Image.asset(
                              "assets/account_100px.png",
                              width: 100,
                            ),
                            Text(
                              "My Profile",
                              style: cardTextStyle,
                            ),
                          ]),
                    ),
                  ),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/courses');
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Image(
                              image: AssetImage("assets/course_100px.png"),
                              width: 100,
                            ),
                            Text(
                              "Courses",
                              style: cardTextStyle,
                            ),
                          ]),
                    ),
                  ),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Image(
                              image: AssetImage("assets/exam_100px.png"),
                              width: 100,
                            ),
                            Text(
                              "Results & CGPA",
                              style: cardTextStyle,
                            ),
                          ]),
                    ),
                  ),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Image(
                              image: AssetImage("assets/timetable_100px.png"),
                              width: 100,
                            ),
                            Text(
                              "Timetable",
                              style: cardTextStyle,
                            ),
                          ]),
                    ),
                  ),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/notes');
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Image(
                              image: AssetImage("assets/note_100px.png"),
                              width: 100,
                            ),
                            Text(
                              "My Notes",
                              style: cardTextStyle,
                            ),
                          ]),
                    ),
                  ),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CuisineScreen()));
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Image(
                              image: AssetImage("assets/book_100px.png"),
                              width: 100,
                            ),
                            Text(
                              "Lecture Notes",
                              style: cardTextStyle,
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
