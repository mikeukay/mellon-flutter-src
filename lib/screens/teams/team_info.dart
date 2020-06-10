import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mellon/models/team.dart';
import 'package:mellon/models/user.dart';
import 'package:mellon/screens/teams/dialogs/email_dialog.dart';
import 'package:mellon/screens/teams/edit_team.dart';
import 'package:mellon/screens/teams/widgets/team_member_card.dart';
import 'package:mellon/services/database.dart';
import 'package:mellon/shared/constants.dart';
import 'package:mellon/shared/loading_widget.dart';
import 'package:provider/provider.dart';

class TeamInfoScreen extends StatefulWidget {

  final Team team;

  TeamInfoScreen({this.team});

  @override
  _TeamInfoScreenState createState() => _TeamInfoScreenState();
}

class _TeamInfoScreenState extends State<TeamInfoScreen> {

  Team _team;
  String error = "";
  bool loading = false;

  void setTeam(Team t) {
    setState(() {
      _team = t;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    Team team = _team == null ? widget.team : _team;

    return Scaffold(
      appBar: AppBar(
        title: Text(team.name),
        centerTitle: true,
      ),
      body: Container(
        width: width,
        child: loading ? LoadingWidget() : Padding(
          padding: EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Description',
                    style: TextStyle(
                      fontSize: width / 20,
                    ),
                  ),
                  team.admin ? IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Constants.kCommentColor,
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EditTeamScreen(team: team, refreshFunc: setTeam)));
                    },
                  ) : Container(),
                ],
              ),
              SizedBox(height: 8.0),
              Text(
                team.description,
                style: TextStyle(
                  color: Constants.kCommentColor,
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Members',
                    style: TextStyle(
                      fontSize: width / 20,
                    ),
                  ),
                  team.admin ? IconButton(
                    icon: Icon(
                      Icons.add_circle_outline,
                      color: Constants.kCommentColor,
                    ),
                    onPressed: () async {
                      String email = await showEmailDialog(context);
                      if(email != '') {
                        setState(() => loading = true);
                        String err = await DatabaseService().addTeamMember(email, team.id);
                        if(err == '') {
                          setState(() {
                            loading = false;
                            error = "";
                          });
                        } else {
                          setState(() {
                            loading = false;
                            error = 'Email not found in our database. Maybe you typed the address wrong?';
                          });
                        }
                      }
                    },
                  ) : Container(),
                ],
              ),
              error == "" ? Container() : Container(
                width: width,
                child: Text(
                  error,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              StreamBuilder(
                stream: team.members,
                initialData: [],
                builder: (context, membersSnapshot) {
                  if(!membersSnapshot.hasData) {
                    return SpinKitWave(
                      color: Constants.kCommentColor,
                      size: width * 0.1,
                    );
                  }
                  List<dynamic> teamMembers = membersSnapshot.data;
                  if(teamMembers.length == 0) {
                    return Text('No team members ?!?!?');
                  }
                  return Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: teamMembers.length,
                        itemBuilder: (context, index) {
                          User u = Provider.of<User>(context);
                          return TeamMemberCard(teamMember: teamMembers[index], admin: team.admin, uid: u.uid);
                        }
                    ),
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
