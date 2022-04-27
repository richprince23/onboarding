import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:onboarding/constants.dart' as constants;
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

class ManageCourses extends StatefulWidget {
  const ManageCourses({Key? key}) : super(key: key);

  @override
  State<ManageCourses> createState() => _ManageCoursesState();
}

class _ManageCoursesState extends State<ManageCourses> {
  final keys = GlobalKey<FormState>();

  final TextEditingController _cCode = TextEditingController();
  final TextEditingController _cTitle = TextEditingController();
  final TextEditingController _cYear = TextEditingController();
  final TextEditingController _cSem = TextEditingController();
  final TextEditingController _cCHours = TextEditingController();

  final List<String> sems = ["Semester 1", "Semester 2"];

  final List<String> levels = [
    '100',
    '200',
    '300',
    '400',
    '500',
    '600',
    '700',
    '800',
    '900'
  ];
  List<Course> courses = [];
  List<Course> courseList = [];

  addCourse() async {
    if (keys.currentState!.validate()) {
      int index = courses.length;

      Course course = Course(
          id: index + 1,
          uid: 1,
          courseCode: _cCode.text,
          courseTitle: _cTitle.text,
          creditHours: _cCHours.text,
          level: levelValue,
          semester: semValue);
      courseList.add(course);
      setState(() {
        courses = courseList;
      });
    }
  }

  var semValue, levelValue;
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
              showAddCourseDialog(context);
            },
            icon: const Icon(Icons.add),
            tooltip: "Add new course",
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
            itemCount: courses.length,
            itemBuilder: (context, int index) {
              return GFListTile(
                color: Colors.white60,
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.symmetric(vertical: 2),
                // style: ListTileStyle.list,
                // textColor: constants.color,
                description: Text("Level: " +
                    courses[index].level +
                    courses[index].semester +
                    " Credit Hours: " +
                    courses[index].creditHours),
                subTitle: Text(courses[index].courseCode),
                titleText: courses[index]
                    .courseTitle, // replace with course code and semester
                title: Text(
                  courses[index].courseCode,
                  style: const TextStyle(fontSize: 16),
                ),
                onTap: () {
                  print(courses[index].courseTitle);
                },
              );
            }),
      ),
    );
  }

  Future<dynamic> showAddCourseDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (ctx) => SimpleDialog(
                shape: const RoundedRectangleBorder(),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Add Course',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                children: [
                  Form(
                      key: keys,
                      child: Column(children: [
                        CustomField(
                          title: "Course Code",
                          controller: _cCode,
                        ),
                        CustomField(
                          title: "Course Title",
                          controller: _cTitle,
                        ),
                        DropdownButtonFormField<String>(
                            dropdownColor: Colors.pinkAccent,
                            menuMaxHeight: 200,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 0),
                                labelText: "Level",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            items: levels.map((String value) {
                              return DropdownMenuItem<String>(
                                  child: Text(value), value: value);
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                levelValue = newValue;
                              });
                            },
                            validator: (e) {
                              if (e == "") {
                                return "Please fill this field";
                              } else {
                                return null;
                              }
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownButtonFormField<String>(
                          dropdownColor: Colors.pinkAccent,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 0),
                              labelText: "Semester",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          items: sems.map((String value) {
                            return DropdownMenuItem<String>(
                                child: Text(value), value: value);
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              semValue = newValue;
                            });
                          },
                          validator: (e) {
                            if (e == "") {
                              return "Please fill this field";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomField(
                          title: "Credit Hours",
                          controller: _cCHours,
                        ),
                        Container(
                          height: 40,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.pinkAccent,
                          ),
                          child: TextButton(
                              onPressed: () async {
                                // save and close
                                await addCourse();
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                "Save",
                                style: TextStyle(color: Colors.white),
                              )),
                        )
                      ]))
                ]));
  }
}

class CustomField extends StatelessWidget {
  String title;
  TextEditingController? controller;

  CustomField({Key? key, required this.title, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                labelText: title,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  // borderSide: BorderSide()
                )),
            controller: controller,
            validator: (e) {
              if (e == "") {
                return "Please fill this field";
              } else {
                return null;
              }
            }),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}

class Course {
  var courseCode;

  var courseTitle;

  var creditHours;

  var id;

  var semester;

  var uid;

  var level;

  Course(
      {this.id,
      this.uid,
      this.courseCode,
      this.courseTitle,
      this.level,
      this.semester,
      this.creditHours});
}
