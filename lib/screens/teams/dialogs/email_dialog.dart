import 'package:flutter/material.dart';
import 'package:mellon/shared/constants.dart';

Future<String> showEmailDialog(context) async {
  String email = "";
  return await showDialog<String>(
    context: context,
    builder: (context) => new AlertDialog(
      contentPadding: const EdgeInsets.all(16.0),
      content: new Row(
        children: <Widget>[
          new Expanded(
            child: new TextField(
              autofocus: true,
              decoration: Constants.kTextInputDecoration.copyWith(
                  labelText: 'Email',
                  hintText: 'eg. foo@bar.com'
              ),
              onChanged: (newValue) {
                email = newValue;
              },
            ),
          )
        ],
      ),
      actions: <Widget>[
        new FlatButton(
            child: const Text('CANCEL'),
            onPressed: () {
              Navigator.pop(context);
              return '';
            }),
        new FlatButton(
            child: const Text('ADD'),
            onPressed: () {
              Navigator.pop(context, email);
              return email;
            })
      ],
    ),
  );
}