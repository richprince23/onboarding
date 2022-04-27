import 'package:flutter/material.dart';
import 'constants.dart' as constants;

class appHead extends StatelessWidget {
  const appHead({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // Container(
        // margin: const EdgeInsets.only(left: 20),
        // child:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              constants.curUser!.displayName.toString(),
              // "James Sekyi",
              style: const TextStyle(
                  color: Colors.white, fontSize: 14, fontFamily: "Raleway"),
            ),
            const Text(
              "BSc Management Education",
              style: TextStyle(
                  color: Colors.white, fontSize: 10, fontFamily: "Raleway"),
            )
          ],
        ),
        // ),
        const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage("chef.png"),
            backgroundColor: Colors.pinkAccent),
      ],
    );
  }
}
