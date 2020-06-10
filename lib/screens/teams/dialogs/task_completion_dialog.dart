import 'package:flutter/material.dart';
import 'package:mellon/models/task.dart';

Future<void> showTaskDialog(BuildContext context, Task task) async {
  SimpleDialog dialog = SimpleDialog(
    title: const Text('Set Task Status'),
    children: [
      SimpleDialogOption(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text('Not Started'),
        ),
        onPressed: () async {
          Navigator.of(context).pop();
          await task.setCompletion(false, false);
        },
      ),
      SimpleDialogOption(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text('In Progress'),
        ),
        onPressed: () async {
          Navigator.of(context).pop();
          await task.setCompletion(true, false);
        },
      ),
      SimpleDialogOption(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text('Completed'),
        ),
        onPressed: () async {
          Navigator.of(context).pop();
          await task.setCompletion(true, true);
        },
      ),
    ],
  );

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return dialog;
    },
  );
}