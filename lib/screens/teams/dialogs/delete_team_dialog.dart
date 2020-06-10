import 'package:flutter/material.dart';

Future<bool> showTeamDeleteDialog(context) async {
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
      "DELETE",
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
    content: Text("Do you really want to delete this team? This action cannot be reversed."),
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