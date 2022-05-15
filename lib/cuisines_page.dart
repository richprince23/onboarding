import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CuisineScreen extends StatefulWidget {
  CuisineScreen({Key? key}) : super(key: key);

  @override
  State<CuisineScreen> createState() => _CuisineScreenState();
}

class _CuisineScreenState extends State<CuisineScreen> {
  bool loading = false;
  List<Cuisine> cuzList = [];

  Future getData() async {
    loading = true;
    var res = await http.get(Uri.https('www.bukyia.com', 'api/cuisines'));
    var jsonData = jsonDecode(res.body);

    for (var i in jsonData) {
      Cuisine cuz = Cuisine(
          i['id'], i['userID'], i['cuisine'], i['created_at'], i['updated_at']);
      cuzList.add(cuz);
    }
    // print(cuzList.length);
    // print(cuzList[0].cuisine);
    return cuzList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cuisines"),
          actions: [
            IconButton(
              onPressed: () {
                getData();
                setState(() {
                  loading = false;
                });
              },
              icon: Icon(Icons.add),
            )
          ],
        ),
        body: ListView.builder(
            primary: false,
            itemCount: cuzList.length,
            itemBuilder: ((context, index) {
              return ListTile(
                title: Text(cuzList[index].cuisine),
              );
            })));
  }
}

class Cuisine {
  final int id, userID;
  final String cuisine, created_at, updated_at;

  Cuisine(this.id, this.userID, this.cuisine, this.created_at, this.updated_at);
}
