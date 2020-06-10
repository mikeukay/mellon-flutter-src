import 'package:flutter/material.dart';
import 'package:mellon/models/task.dart';
import 'package:mellon/screens/teams/dialogs/task_admin_dialog.dart';
import 'package:mellon/screens/teams/dialogs/task_completion_dialog.dart';
import 'package:mellon/shared/constants.dart';

class TaskCard extends StatelessWidget {

  final Task task;
  final bool admin;

  TaskCard({this.task, this.admin});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              task.started ? (task.completed ? Icons.playlist_add_check : Icons.work) : (task.completed ? Icons.all_inclusive : Icons.description),
            ),
            Text(
              task.started ? (task.completed ? 'Completed' : 'In progress') : (task.completed ? 'IDK I Quit' : 'Not started'),
              style: TextStyle(
                color: Constants.kCommentColor,
              ),
            ),
          ],
        ),
        title: Text(task.name),
        subtitle: Text(task.description),
        onTap: () async {
          await showTaskDialog(context, task);
        },
        onLongPress: () async {
          if(admin) {
            await AdminDialogModal().show(context, task);
          }
        },
      ),
    );
  }
}
