import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:onboarding/models/courses_db.dart';

class PortalDatabase {
  static final PortalDatabase instance = PortalDatabase._init();

  static Database? _database;

  PortalDatabase._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB('portals.db');
      return _database!;
    }
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: createDB);
  }

  Future createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = "STRING NOT NULL";
    final intType = "INTEGER NOT NULL";

    await db.execute('''
  CREATE TABLE $coursesTable(
    ${CourseFields.id} $idType, ${CourseFields.courseCode} $textType,
    ${CourseFields.courseTitle} $textType, ${CourseFields.semester} $textType,
    ${CourseFields.level} $textType, ${CourseFields.creditHours} $textType
  );
  
''');
  }

  Future<Course> addCourse(Course course) async {
    final db = await instance.database;

    final id = await db.insert(coursesTable, course.toJson());
    return course.copy(id: id);
  }

  Future<Course?> getCourse(int id) async {
    final db = await instance.database;

    final results = await db.query('courses',
        columns: [CourseFields.id.toString()],
        where: 'id = ?',
        whereArgs: [id]);
    if (results.isNotEmpty) {
      return Course.fromJson(results.first);
    } else {
      return null;
    }
  }

  Future<List<Course>> getCourses() async {
    final db = await instance.database;

    final results = await db.query(coursesTable);
    return results.map((json) => Course.fromJson(json)).toList();
    // if (results.isNotEmpty) {
    //   return Course.fromJson(results.first);
    // } else {
    //   return null;
    // }
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
