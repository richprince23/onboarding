import 'dart:convert';

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
  getData() async {
    loading = true;
    var res =
        await http.get(Uri.http('http://localhost:8000/api/cuisines', '16'));
    var jsonData = jsonDecode(res.body);

    List<Cuisine> cuzList = [];
    for (var i in jsonData) {
      Cuisine cuz = Cuisine(
          i['id'], i['userID'], i['cuisine'], i['created_at'], i['updated_at']);
      cuzList.add(cuz);
      print(cuzList.length);
      print("fsdfds");

      return cuzList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cuisines"),
      ),
      body: Center(
          child: Column(
        children: [
          TextButton(
              onPressed: () {
                getData();
                // setState((){
                //   loading =false;
                // });
              },
              child: Text("Load Data")),
          // FutureBuilder(
          //     future: getData(),
          //     builder: (context, snapshot) {
          //       if (snapshot.data == null)
          //         return const CircularProgressIndicator(
          //           color: Colors.pink,
          //           value: 80,
          //         );

          //       return ListView.builder(
          //           // itemCount: snapshot.data!.length,
          //           itemBuilder: ((context, index) {
          //             return ListTile(
          //               title: Text(snapshot.data![index].userID),
          //             );
          //           }));
          //     })
        ],
      )),
    );
  }
}

class Cuisine {
  final int id, userID;
  final String cuisine, created_at, updated_at;

  Cuisine(this.id, this.userID, this.cuisine, this.created_at, this.updated_at);
}
