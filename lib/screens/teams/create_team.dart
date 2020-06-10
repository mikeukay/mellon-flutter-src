import 'package:flutter/material.dart';
import 'package:mellon/models/user.dart';
import 'package:mellon/services/database.dart';
import 'package:mellon/shared/constants.dart';
import 'package:mellon/shared/loading_widget.dart';
import 'package:provider/provider.dart';

class CreateTeamScreen extends StatefulWidget {
  @override
  _CreateTeamScreenState createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends State<CreateTeamScreen> {

  final _formKey = GlobalKey<FormState>();

  String teamName = "";
  String teamDesc = "";

  String errorText = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a Team'),
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
                    decoration: Constants.kTextInputDecoration.copyWith(labelText: "Team Description", hintText: "e.g. Official group for RC Marketing Dept"),
                  ),
                  SizedBox(height: 16.0),
                  RaisedButton(
                    color: Constants.kPrimaryColor,
                    child: Text(
                      'Create',
                      style: TextStyle(
                        color: Constants.kBackgroundColor,
                      ),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState.validate()) {
                        setState(() {
                          loading = true;
                        });
                        String err = await DatabaseService().createTeam(teamName, teamDesc, user);
                        if(err == '') {
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
