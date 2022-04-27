import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PortalDatabase {
  static final PortalDatabase instance = PortalDatabase._init();

  static Database? _database;

  PortalDatabase._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB('portal.db');
      return _database!;
    }
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = "/assets/db/";
  
    final path = join(dbPath, filePath);
    return await openDatabase(path);
  }
}
