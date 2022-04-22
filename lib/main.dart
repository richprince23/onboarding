import 'package:flutter/material.dart';
import 'package:onboarding/courses.dart';
import 'package:onboarding/login_screen.dart';
import 'package:onboarding/onBoardingScreen.dart';
import 'package:onboarding/profile.dart';
import 'welcomeScreen.dart';
import 'homepage.dart';
// import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  // try {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   await Firebase.initializeApp(
  //       options: const FirebaseOptions(
  //     apiKey: "AIzaSyBgpYnxE40di-BX5P2UpUlNREwA9Z1WjFU",
  //     appId: "1:544166817212:android:0a81165f2f87c0ab854fb9",
  //     messagingSenderId: "XXX",
  //     projectId: "my-portall",
  //   ));
  // } on Exception catch (e) {
  //   // TODO
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Portal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const WelcomeScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => ManageCourses(),
        '/profile': (context) => Profile(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => OnBoardingScreen(),
        '/home': (context) => HomePage(),
        '/startup': (context) => WelcomeScreen(),
        '/courses': (context) => ManageCourses(),
      },
    );
  }
}
