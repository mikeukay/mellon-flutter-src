import 'package:flutter/material.dart';
import 'package:mellon/models/team.dart';
import 'package:mellon/models/user.dart';
import 'package:mellon/screens/teams/create_team.dart';
import 'package:mellon/screens/teams/noteams.dart';
import 'package:mellon/screens/teams/widgets/team_card.dart';
import 'package:mellon/shared/constants.dart';
import 'package:mellon/services/auth.dart';
import 'package:mellon/shared/loading_widget.dart';
import 'package:provider/provider.dart';

class TeamsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Teams'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Icon(
              Icons.exit_to_app,
              color: Constants.kBackgroundColor,
            ),
            onPressed: () {
              AuthenticationService().logOut();
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Team>>(
        stream: user.teams,
        builder: (context, teamsSnapshot) {
          if(!teamsSnapshot.hasData) {
            return LoadingWidget();
          }
          List<Team> teams = teamsSnapshot.data;
          if(teams.length == 0) {
            return NoTeamsScreen();
          }

          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ListView.builder(
              itemCount: teams.length,
              itemBuilder: (context, index) {
                return TeamCard(team: teams[index]);
              },
            ),
          );
        }
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CreateTeamScreen()));
          },
          child: Icon(Icons.add),
          backgroundColor: Constants.kPrimaryColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
