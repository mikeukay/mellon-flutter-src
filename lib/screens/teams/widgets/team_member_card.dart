import 'package:flutter/material.dart';
import 'package:mellon/models/team_member.dart';
import 'package:mellon/screens/teams/dialogs/kick_teammate_dialog.dart';
import 'package:mellon/screens/teams/dialogs/leave_team_dialog.dart';
import 'package:mellon/screens/teams/dialogs/delete_team_dialog.dart';

class TeamMemberCard extends StatelessWidget {

  final TeamMember teamMember;
  final bool admin;
  final String uid;

  TeamMemberCard({this.teamMember, this.admin, this.uid});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(teamMember.email),
      subtitle: teamMember.admin ? Text('Admin') : Text('Member'),
      trailing: !admin ? null : PopupMenuButton<String>(
          onSelected: (String choice) async {
            switch (choice) {
              case 'Leave':
                bool reallyLeave = await showLeaveDialog(context);
                if(reallyLeave) {
                  Navigator.of(context).pop();
                  await teamMember.kick();
                }
                break;
              case 'Delete Team':
                bool reallyDelete = await showTeamDeleteDialog(context);
                if(reallyDelete) {
                  Navigator.of(context).pop();
                  await teamMember.deleteTeam();
                }
                break;
              case 'Kick':
                bool reallyKick = await showKickDialog(context, teamMember.email);
                if(reallyKick) {
                  await teamMember.kick();
                }
                break;
              case 'Make Admin':
                await teamMember.makeAdmin();
                break;
              case 'Revoke Admin':
                await teamMember.revokeAdmin();
                break;
            }
          },
          itemBuilder: (BuildContext context) {
            List<String> options = new List<String>();
            if(teamMember.uid != uid) {
              options.add('Kick');
              if(teamMember.admin) {
                options.add('Revoke Admin');
              } else {
                options.add('Make Admin');
              }
            } else {
              options.add('Leave');
              if(teamMember.admin) {
                options.add('Delete Team');
              }
            }
            return options.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          }
      ),
    );
  }
}
