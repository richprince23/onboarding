import 'package:flutter/material.dart';
import 'package:onboarding/add_note.dart';
import 'package:onboarding/courses.dart';
import 'package:onboarding/login_screen.dart';
import 'package:onboarding/my_notes.dart';
import 'package:onboarding/onBoardingScreen.dart';
import 'package:onboarding/profile.dart';
import 'package:onboarding/read_note.dart';
import 'welcomeScreen.dart';
import 'homepage.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyBgpYnxE40di-BX5P2UpUlNREwA9Z1WjFU",
      appId: "1:544166817212:android:0a81165f2f87c0ab854fb9",
      messagingSenderId: "XXX",
      projectId: "my-portall",
    ));
    runApp(MyApp());
  } on Exception catch (e) {
    print('Error: $e');
  }
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  late int noteID;
  final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
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
      navigatorObservers: [routeObserver],
      initialRoute: '/home',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/profile': (context) => Profile(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const OnBoardingScreen(),
        '/home': (context) => const HomePage(),
        '/startup': (context) => const WelcomeScreen(),
        '/courses': (context) => const ManageCourses(),
        '/notes': (context) => MyNotes(),
        '/add-note': (context) => const AddNoteScreen(),
        // '/read-note': (context) => ReadOnlyPage(noteID: noteID),
      },
    );
  }
}
