import 'package:flutter/material.dart';
import 'package:mellon/models/task.dart';
import 'package:mellon/shared/constants.dart';

class AdminDialogModal {

  Task _task;

  Future<void> show(BuildContext context, Task task) async {
    _task = task;
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (builder) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _createTile(context, "Delete Task", _deleteTask, Icons.delete),
              _createTile(context, "Edit Name", _editName, Icons.edit),
              _createTile(context, "Edit Description", _editDescription, Icons.edit),
            ],
          );
        }
    );
  }

  Widget _createTile(BuildContext context, String text, Function action, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: () async {
        Navigator.pop(context);
        await action(context);
      },
    );
  }

  Future<void> _deleteTask(BuildContext context) async {
    _task.delete();
  }

  Future<void> _editName(BuildContext context) async {
    String newName = await _showTextDialog(context, "Set Task Name", _task.name, 32, false);
    if(newName != _task.name) {
      _task.updateName(newName);
    }
  }

  Future<void> _editDescription(BuildContext context) async {
    String newDesc = await _showTextDialog(context, "Set Task Description", _task.description, 512, true);
    if(newDesc != _task.description) {
      _task.updateDescription(newDesc);
    }
  }

  Future<String> _showTextDialog(BuildContext context, String title, String initialValue, int maxChars, bool multiline) async {
    String value = initialValue;
    bool submit = false;

    await showDialog<String>(
      context: context,
      builder: (context) => new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(title),
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: new TextFormField(
                autofocus: true,
                maxLength: maxChars,
                maxLines: multiline ? null : 1,
                initialValue: initialValue,
                decoration: Constants.kTextInputDecoration,
                onChanged: (newValue) {
                  value = newValue;
                },
              ),
            )
          ],
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
                return '';
              }),
          new FlatButton(
              child: const Text('Submit'),
              onPressed: () {
                submit = true;
                Navigator.pop(context);
              })
        ],
      ),
    );

    return submit ? value : initialValue;
  }

}