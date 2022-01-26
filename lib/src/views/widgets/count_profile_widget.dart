import 'package:flutter/material.dart';

Column buildCountColumn(String label, int? count) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        count.toString(),
        style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
      ),
      Container(
        margin: const EdgeInsets.only(top: 4.0),
        child: Text(
          label,
          style: const TextStyle(
              color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.w400),
        ),
      )
    ],
  );
}
