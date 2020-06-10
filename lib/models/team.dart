import 'package:mellon/models/team_member.dart';
import 'package:mellon/models/task.dart';
import 'package:mellon/services/database.dart';

class Team {
  String id;
  String name;
  String description;
  bool admin;

  Team({this.id, this.name, this.description, this.admin});

  String getShortDescription() {
    int maxLen = 42;
    if(description.length < maxLen) {
      return description;
    } else {
      return description.substring(0, maxLen - 3) + "...";
    }
  }

  Stream<List<TeamMember>> get members {
    return DatabaseService().getTeamMembers(id);
  }

  Stream<List<Task>> get tasks {
    return DatabaseService().getTeamTasks(id);
  }

  Future<String> createTask(String taskName, String taskDesc) async {
    return DatabaseService().createTaskForTeam(id, taskName, taskDesc);
  }

}