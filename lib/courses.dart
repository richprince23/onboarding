import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:onboarding/constants.dart' as constants;

import 'models/courses_db.dart';
import 'db/portal_database.dart';

class ManageCourses extends StatefulWidget {
  const ManageCourses({Key? key}) : super(key: key);

  @override
  State<ManageCourses> createState() => _ManageCoursesState();
}

class _ManageCoursesState extends State<ManageCourses> {
  late List<Course> courses;

  bool isLoading = false;

  readCourse() {
    var res = PortalDatabase.instance.getCourse(0);
    setState(() {
      // courses.add(res);
    });
  }

  @override
  void initState() {
    super.initState();
    readCourses();
    // PortalDatabase.instance.delDB();
  }

  Future readCourses() async {
    setState(() {
      isLoading = true;
    });
    courses = await PortalDatabase.instance.getCourses();

    setState(() {
      isLoading = false;
    });
  }

  Widget buildCourses() => ListView.builder(
      itemCount: courses.length,
      itemBuilder: (context, int index) {
        var course = courses[index];
        return GFListTile(
          color: ThemeData.light().secondaryHeaderColor,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(vertical: 1),
          description: Text("Level: " +
              course.level.toString() +
              " " +
              course.semester +
              " Credit Hours: " +
              course.creditHours.toString() +
              " "),
          subTitle: Text(course.courseCode.toString()),
          titleText:
              course.courseTitle, // replace with course code and semester
          title: Text(
            course.courseCode.toString(),
            style: const TextStyle(fontSize: 16),
          ),
          onTap: () {},
        );
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Courses"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: constants.color,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, '/add-course');
            },
            icon: const Icon(Icons.add),
            tooltip: "Add new course",
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : courses.isEmpty
                ? const Text("No courses added")
                : buildCourses(),
      ),
    );
  }
}
