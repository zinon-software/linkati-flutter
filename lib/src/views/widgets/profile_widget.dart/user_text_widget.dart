import 'package:flutter/cupertino.dart';

Container userText({String? text, double paddingTop = 12.0}) => Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(top: paddingTop),
      child: Text(
        text!,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
      ),
    );
