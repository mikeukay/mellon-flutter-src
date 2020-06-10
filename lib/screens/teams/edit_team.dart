import 'package:flutter/material.dart';
import 'package:mellon/models/team.dart';
import 'package:mellon/services/database.dart';
import 'package:mellon/shared/constants.dart';
import 'package:mellon/shared/loading_widget.dart';

class EditTeamScreen extends StatefulWidget {

  final Team team;
  final Function refreshFunc;

  EditTeamScreen({this.team, this.refreshFunc});

  @override
  _EditTeamScreenState createState() => _EditTeamScreenState();
}

class _EditTeamScreenState extends State<EditTeamScreen> {

  final _formKey = GlobalKey<FormState>();

  Team _team;

  String teamName = "";
  String teamDesc = "";

  String errorText = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    Team team = _team == null ? widget.team : _team;
    if(teamName == "") {
      teamName = widget.team.name;
    }
    if(teamDesc == "") {
      teamDesc = widget.team.description;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Team'),
        centerTitle: true,
      ),
      body: loading ? LoadingWidget() : SingleChildScrollView(
        child: Container(
          width: width,
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.people,
                    size: width * 0.5,
                    color: Constants.kCommentColor,
                  ),
                  TextFormField(
                    validator: (val) {
                      if(val.length == 0) {
                        return 'Team name cannot be empty!';
                      }
                      if(val.length > 32) {
                        return 'Team name too long!';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() {
                        teamName = val;
                      });
                    },
                    maxLength: 32,
                    maxLines: 1,
                    decoration: Constants.kTextInputDecoration.copyWith(labelText: "Team Name", hintText: "e.g. RealCorp - Marketing"),
                    initialValue: team.name,
                  ),
                  TextFormField(
                    validator: (val) {
                      if(val.length == 0) {
                        return 'Team description cannot be empty!';
                      }
                      if(val.length > 512) {
                        return 'Team description too long!';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() {
                        teamDesc = val;
                      });
                    },
                    maxLength: 512,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    initialValue: team.description,
                    decoration: Constants.kTextInputDecoration.copyWith(labelText: "Team Description", hintText: "e.g. Official group for RC Marketing Dept"),
                  ),
                  SizedBox(height: 16.0),
                  RaisedButton(
                    color: Constants.kPrimaryColor,
                    child: Text(
                      'Edit',
                      style: TextStyle(
                        color: Constants.kBackgroundColor,
                      ),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState.validate()) {
                        setState(() {
                          loading = true;
                        });
                        String err = '';
                        team.name = teamName;
                        team.description = teamDesc;
                        await DatabaseService().editTeam(team.id, teamName, teamDesc);
                        if(err == '') {
                          widget.refreshFunc(widget.team);
                          Navigator.pop(context);
                        }
                        setState(() {
                          errorText = err;
                          loading = false;
                        });
                      }
                    },
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    errorText,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
