import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onboarding/constants.dart' as constants;
import 'package:path_provider/path_provider.dart' as path;

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ImagePicker imagePicker = ImagePicker();

  final keys = GlobalKey<FormState>();

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

  var levelController;
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController course = TextEditingController();
  TextEditingController level = TextEditingController();

  File? selectedImage = null;

  Future getImagefromGallery() async {
    try {
      final image = await imagePicker.pickImage(source: ImageSource.gallery);
      // selectedImage.saveTo('/assets');
      if (image == null) return;

      final tempImage = File(image.path);

      // selectedImage = tempImage;
      // var file = await File(image.path).copy("/assets");
      // print(image.path);
      setState(() {
        selectedImage = tempImage;
      });
    } on PlatformException catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: constants.color,
        elevation: 0,
        title: Text("Update Profile"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.popAndPushNamed((context), '/home');
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Container(
        // width: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    selectedImage != null
                        ? CircleAvatar(
                            // backgroundImage: createImage(),
                            child: createImage(context),
                            radius: 50,
                          )
                        : CircleAvatar(
                            backgroundImage: AssetImage("chef.png"),
                            radius: 50,
                          ),
                    TextButton(
                        onPressed: () async {
                          getImagefromGallery();
                        },
                        child: const Text("Choose Image",
                            style: TextStyle(fontSize: 16))),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.80,
                child: Form(
                    key: keys,
                    child: Column(
                      children: [
                        LabeledFormField(
                          label: "First Name",
                          hintText: "First Name",
                          controller: fname,
                          type: TextInputType.name,
                        ),
                        LabeledFormField(
                          label: "Last Name",
                          hintText: "Last Name",
                          controller: lname,
                          type: TextInputType.name,
                        ),
                        LabeledFormField(
                          label: "Email Address",
                          hintText: "Email Address",
                          controller: email,
                          type: TextInputType.emailAddress,
                        ),
                        LabeledFormField(
                          label: "Phone Number",
                          hintText: "Phone Number",
                          controller: phone,
                          type: TextInputType.phone,
                        ),
                        LabeledFormField(
                          label: "Course",
                          hintText: "Course",
                          controller: course,
                        ),
                        // LabeledFormField(
                        //   label: "Level",
                        //   hintText: "Level",
                        //   controller: level,
                        // ),
                        DropdownButtonFormField<String>(
                          items: levels.map((String value) {
                            return DropdownMenuItem<String>(
                                child: Text(value), value: value);
                          }).toList(),
                          onChanged: (newValue) {
                            // print(newValue);
                            setState(() {
                              levelController = newValue;
                            });
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white10,
                            hintText: "Select Level",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Colors.pinkAccent, width: 1)),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                          ),
                          validator: (value) {
                            if (value == "") {
                              return "Please fill this field";
                            } else {
                              return null;
                            }
                          },
                        ),

                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.pinkAccent),
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: 40,
                          margin: EdgeInsets.only(bottom: 40, top: 40),
                          child: TextButton(
                              onPressed: () {
                                if (keys.currentState!.validate()) {
                                  print('Saved');
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (ctx) => const AlertDialog(
                                          title: Text(' Login-in Failed'),
                                          content: Text("Saving Failed")));
                                }
                              },
                              // icon: Icon(Icons.create),
                              child: Text(
                                "Update",
                                style: TextStyle(color: Colors.white),
                              )),
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  createImage(BuildContext context) {
    if (Platform.operatingSystem == "android" ||
        Platform.operatingSystem == "ios") {
      return AssetImage(
        selectedImage.toString(),
      );
    } else {
      return NetworkImage(selectedImage!.path);
    }
  }
}

class LabeledFormField extends StatelessWidget {
  TextEditingController? controller;

  String? hintText;

  String label;

  TextInputType? type;

  LabeledFormField(
      {Key? key,
      required this.label,
      this.hintText,
      this.controller,
      this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
          child: Text(
            label,
            style: TextStyle(
              fontFamily: "Raleway",
            ),
            textAlign: TextAlign.start,
          ),
        ),
        TextFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white10,
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.pinkAccent, width: 1)),
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          ),
          controller: controller,
          keyboardType: type,
          validator: (value) {
            if (value == "") {
              return "Please fill this field";
            } else {
              return null;
            }
          },
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
