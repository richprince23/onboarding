import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/getwidget.dart';
import 'package:onboarding/constants.dart' as Const;

class ManageCourses extends StatefulWidget {
  ManageCourses({Key? key}) : super(key: key);

  @override
  State<ManageCourses> createState() => _ManageCoursesState();
}

class _ManageCoursesState extends State<ManageCourses> {
  final List<String> sems = ["Semester 1", "Semester 2"];
  var semValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Courses"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        backgroundColor: Const.color,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              showAddCourseDialog(context);
            },
            icon: Icon(Icons.add),
            tooltip: "Add new course",
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
            itemCount: sems.length,
            itemBuilder: (context, int index) {
              return GFListTile(
                color: Colors.white60,
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.symmetric(vertical: 2),
                // style: ListTileStyle.list,
                // textColor: Const.color,
                subTitle: Text(index.toString()),
                titleText: sems[index], // replace with course code and semester
                title: Text(
                  sems[index],
                  style: const TextStyle(fontSize: 16),
                ),
                onTap: () {
                  print(sems[index]);
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
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close),
                      tooltip: "Close",
                    )
                  ],
                ),
                children: [
                  CustomField(
                    title: "Course Code",
                  ),
                  CustomField(
                    title: "Course Name",
                  ),
                  DropdownButtonFormField<String>(
                      dropdownColor: Colors.pinkAccent,
                      decoration: InputDecoration(
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
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomField(
                    title: "Credit Hours",
                  ),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.pinkAccent,
                    ),
                    child: TextButton(
                        onPressed: () {
                          // save and close
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        )),
                  )
                ]));
  }
}

class CustomField extends StatelessWidget {
  String title;

  CustomField({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              labelText: title,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                // borderSide: BorderSide()
              )),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
