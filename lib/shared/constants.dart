import 'package:flutter/material.dart';

class Constants {
  static Color kBackgroundColor = Colors.white;
  static Color kPrimaryColor = Colors.purple[700];
  static Color kCommentColor = Colors.grey[600];

  static InputDecoration kTextInputDecoration = InputDecoration(
    filled: false,
    contentPadding: EdgeInsets.all(12.0),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: kCommentColor, width: 1.0),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
    ),
  );
}