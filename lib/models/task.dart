import 'package:mellon/services/database.dart';

class Task {
  String teamId;
  String taskId;
  String name;
  String description;
  bool started;
  bool completed;

  Task({this.teamId, this.taskId, this.name, this.description, this.started, this.completed});

  Future<void> setCompletion(bool newStarted, bool newCompleted) async {
    started = newStarted;
    completed = newCompleted;
    await DatabaseService().updateTask(teamId, taskId, name, description, newStarted, newCompleted);
  }

  Future<void> delete() async {
    await DatabaseService().deleteTask(teamId, taskId);
  }

  Future<void> updateName(String newName) async {
    name = newName;
    await DatabaseService().updateTask(teamId, taskId, newName, description, started, completed);
  }

  Future<void> updateDescription(String newDesc) async {
    description = newDesc;
    await DatabaseService().updateTask(teamId, taskId, name, newDesc, started, completed);
  }
}