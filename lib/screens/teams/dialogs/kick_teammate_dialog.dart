import 'package:flutter/material.dart';

Future<bool> showKickDialog(context, email) async {
  bool kick = false;

  Widget cancelButton = FlatButton(
    child: Text("Cancel"),
    onPressed:  () {
      kick = false;
      Navigator.of(context).pop();
    },
  );
  Widget kickButton = FlatButton(
    child: Text(
        "Kick!",
        style: TextStyle(
          color: Colors.red
        ),
    ),
    onPressed:  () {
      kick = true;
      Navigator.of(context).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("Are you sure?"),
    content: Text("Do you really want to kick " + email + " from this team?"),
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

  return kick;
}