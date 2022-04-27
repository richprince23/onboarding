import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'constants.dart' as constants;

class DBHelper {
  void openDB() async {
    var db = await openDatabase("my_portal");
  }
}
