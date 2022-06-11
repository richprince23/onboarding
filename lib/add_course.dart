import 'package:flutter/material.dart';
import 'package:onboarding/db/portal_database.dart';
import 'constants.dart' as constants;
import 'models/courses_db.dart';
import 'db/portal_database.dart';

class AddCoursePage extends StatefulWidget {
  const AddCoursePage({Key? key}) : super(key: key);

  @override
  State<AddCoursePage> createState() => _AddCoursePageState();
}

class _AddCoursePageState extends State<AddCoursePage> {
  final keys = GlobalKey<FormState>();

  final TextEditingController _cCode = TextEditingController();
  final TextEditingController _cTitle = TextEditingController();
  // final TextEditingController _cYear = TextEditingController();
  // final TextEditingController _cSem = TextEditingController();
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

  late List<Course> courses;
  List<Course> courseList = [];
  bool isLoading = false;

  var semValue, levelValue;

  Future newCourse() async {
    // if (keys.currentState!.validate()) {
    //     // int index = courses.length;
    Course course = Course(
      courseCode: _cCode.text,
      courseTitle: _cTitle.text,
      creditHours: _cCHours.text,
      level: levelValue.toString(),
      semester: semValue.toString(),
    );

    await PortalDatabase.instance.addCourse(course);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Add Course"),
            centerTitle: true,
            elevation: 0,
            backgroundColor: constants.color,
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () async {
                  Navigator.pop(context);
                })),
        body: SingleChildScrollView(
            // primary: true,
            child: Center(
          child: Container(
            // color: Colors.black87,
            alignment: Alignment.center,
            // padding: const EdgeInsets.symmetric(horizontal: 20),
            constraints: BoxConstraints.expand(
              width: MediaQuery.of(context).size.width * .8,
              height: MediaQuery.of(context).size.height * .8,
            ),
            child: Form(
                key: keys,
                // autovalidateMode: AutovalidateMode.always,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomField(
                        title: "Course Code",
                        controller: _cCode,
                      ),
                      CustomField(
                        title: "Course Title",
                        controller: _cTitle,
                      ),
                      DropdownButtonFormField<String>(
                          // dropdownColor: Colors.pinkAccent,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: "Raleway"),
                          menuMaxHeight: 200,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              // labelText: "Semester",
                              hintText: "Level",
                              hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontFamily: "Raleway"),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(
                                    color: Colors.pinkAccent,
                                    width: 3,
                                  )),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(25))),
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
                            if (e == null) {
                              return "Please fill this field";
                            } else {
                              return null;
                            }
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField<String>(
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: "Raleway"),
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            // labelText: "Semester",
                            hintText: "Semester",
                            hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontFamily: "Raleway"),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                  color: Colors.pinkAccent,
                                  width: 3,
                                )),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(25))),
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
                          if (e == null) {
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
                        height: 60,
                        width: MediaQuery.of(context).size.width * .8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.pinkAccent,
                        ),
                        child: TextButton(
                            onPressed: () async {
                              if (keys.currentState!.validate()) {
                                await newCourse().then((value) {
                                  print(value);
                                  Navigator.of(context)
                                      .popAndPushNamed('/courses');
                                });
                              }
                            },
                            child: const Text(
                              "Save",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Raleway",
                                  fontSize: 16),
                            )),
                      )
                    ])),
          ),
        )));
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
            style: const TextStyle(
                color: Colors.black, fontSize: 14, fontFamily: "Raleway"),
            decoration: InputDecoration(
                // constraints: BoxConstraints.expand(height: 60),
                isCollapsed: false,
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                // labelText: title,
                hintText: title,
                hintStyle: const TextStyle(
                    color: Colors.grey, fontSize: 14, fontFamily: "Raleway"),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none
                    // borderSide: BorderSide()
                    ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                      color: Colors.pinkAccent,
                      width: 3,
                    ))),
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
