import 'package:flutter/material.dart';
import 'package:mellon/models/team.dart';
import 'package:mellon/screens/teams/team_info.dart';
import 'package:mellon/screens/teams/tasks/team_tasks.dart';

class TeamCard extends StatelessWidget {

  final Team team;

  TeamCard({this.team});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12.0, 2.0, 12.0, 0.0),
      child: Card(
        child: ListTile(
          title: Text(team.name),
          subtitle: Text(team.getShortDescription()),
          trailing: IconButton(
            icon: Icon(
              Icons.info_outline,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TeamInfoScreen(team: team)));
            },
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => TeamTaskScreen(team: team)));
          },
        ),
      ),
    );
  }
}
