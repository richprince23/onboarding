import 'package:flutter/material.dart';
import 'constants.dart';

class appHead extends StatelessWidget {
  const appHead({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            height: 64,
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        // Constants().curUser!.displayName.toString(),
                        "James Sekyi",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: "Raleway"),
                      ),
                      const Text(
                        "BSc Management Education",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontFamily: "Raleway"),
                      )
                    ],
                  ),
                ),
                const CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage("chef.png"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
