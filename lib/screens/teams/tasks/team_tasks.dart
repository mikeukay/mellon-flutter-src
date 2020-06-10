import 'package:flutter/material.dart';
import 'package:mellon/models/task.dart';
import 'package:mellon/models/team.dart';
import 'package:mellon/screens/teams/tasks/notasks.dart';
import 'package:mellon/screens/teams/widgets/task_card.dart';
import 'package:mellon/screens/teams/tasks/team_create_task.dart';
import 'package:mellon/shared/constants.dart';
import 'package:mellon/shared/loading_widget.dart';

class TeamTaskScreen extends StatelessWidget {

  final Team team;

  TeamTaskScreen({this.team});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(team.name),
        centerTitle: true,
      ),
      backgroundColor: Constants.kBackgroundColor,
      body: Container(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
              child: Text(
                'Tasks',
                style: TextStyle(
                  fontSize: width * 0.1,
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<List<Task>>(
                  stream: team.tasks,
                  builder: (context, tasksSnapshot) {
                    if(!tasksSnapshot.hasData) {
                      return LoadingWidget();
                    }
                    List<Task> tasks = tasksSnapshot.data;
                    if(tasks.length == 0) {
                      return NoTasksScreen();
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                          child: TaskCard(task: tasks[index], admin: team.admin),
                        );
                      },
                    );
                  }
              ),
            ),
        ],
        ),
      ),
      floatingActionButton: team.admin ? Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CreateTaskScreen(team: team,)));
          },
          child: Icon(Icons.add),
          backgroundColor: Constants.kPrimaryColor,
        ),
      ) : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
