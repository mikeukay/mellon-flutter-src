import 'package:flutter/material.dart';

Future<bool> showLeaveDialog(context) async {
  bool leave = false;

  Widget cancelButton = FlatButton(
    child: Text("Cancel"),
    onPressed:  () {
      leave = false;
      Navigator.of(context).pop();
    },
  );
  Widget kickButton = FlatButton(
    child: Text(
      "Leave",
      style: TextStyle(
          color: Colors.red
      ),
    ),
    onPressed:  () {
      leave = true;
      Navigator.of(context).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("Are you sure?"),
    content: Text("Do you really want to leave this team?"),
    actions: [
      cancelButton,
      kickButton,
    ],
  );

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );

  return leave;
}