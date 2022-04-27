import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// class Constants {
User? curUser = FirebaseAuth.instance.currentUser;
Color color = const Color.fromRGBO(117, 64, 237, 1);

BoxDecoration boxDecoration = const BoxDecoration(
    gradient: LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color.fromRGBO(117, 64, 237, 1),
    Colors.purple,
  ],
));
// }
