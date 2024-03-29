import 'dart:io';

import 'package:flutter/material.dart';
import 'package:getwidget/components/drawer/gf_drawer.dart';
// import 'package:getwidget/components/drawer/gf_drawer_header.dart';
import 'constants.dart' as constants;

class appDrawer extends StatelessWidget {
  const appDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GFDrawer(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(children: [
            // GFDrawerHeader()
            UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: constants.color,
                ),
                currentAccountPicture: const CircleAvatar(
                  child: Text("Avatar"),
                  radius: 25,
                ),
                accountName: Text(constants.curUser!.displayName.toString()),
                accountEmail: Text(constants.curUser!.email.toString())
                // accountEmail: Text("aaa@aaa.com")),
                // accountName: Text("James Sakyi"),
                ),
            ListTile(
              leading: const Icon(
                Icons.info,
                color: Color.fromRGBO(117, 64, 237, 1),
              ),
              title: const Text(
                "Profile",
                style: TextStyle(
                    color: Color.fromRGBO(117, 64, 237, 1),
                    fontFamily: "Raleway",
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              onTap: () {
                print("addda");
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.person,
                color: Color.fromRGBO(117, 64, 237, 1),
              ),
              title: const Text(
                "Account",
                style: TextStyle(
                    color: Color.fromRGBO(117, 64, 237, 1),
                    fontFamily: "Raleway",
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              onTap: () {
                print("addda");
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
                color: Color.fromRGBO(117, 64, 237, 1),
              ),
              title: const Text(
                "Settings",
                style: TextStyle(
                    color: Color.fromRGBO(117, 64, 237, 1),
                    fontFamily: "Raleway",
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              onTap: () {
                print("addda");
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.exit_to_app,
                color: Color.fromRGBO(117, 64, 237, 1),
              ),
              title: const Text(
                "Exit",
                style: TextStyle(
                    color: Color.fromRGBO(117, 64, 237, 1),
                    fontFamily: "Raleway",
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              onTap: () {
                exit(1);
              },
            ),
          ]),
        ),
      ),
    );
  }
}
