import 'package:flutter/material.dart';
import 'package:mellon/models/team.dart';
import 'package:mellon/shared/constants.dart';
import 'package:mellon/shared/loading_widget.dart';

class CreateTaskScreen extends StatefulWidget {

  final Team team;

  CreateTaskScreen({this.team});

  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {

  final _formKey = GlobalKey<FormState>();

  String taskName = "";
  String taskDesc = "";

  String errorText = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('New Task'),
        centerTitle: true,
      ),
      backgroundColor: Constants.kBackgroundColor,
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
                    Icons.playlist_add_check,
                    size: width * 0.5,
                    color: Constants.kCommentColor,
                  ),
                  TextFormField(
                    validator: (val) {
                      if(val.length == 0) {
                        return 'Task name cannot be empty!';
                      }
                      if(val.length > 32) {
                        return 'Task name too long!';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() {
                        taskName = val;
                      });
                    },
                    maxLength: 32,
                    maxLines: 1,
                    decoration: Constants.kTextInputDecoration.copyWith(labelText: "Task Name", hintText: "e.g. Make a sandwich"),
                  ),
                  TextFormField(
                    validator: (val) {
                      if(val.length == 0) {
                        return 'Task description cannot be empty!';
                      }
                      if(val.length > 512) {
                        return 'Task description too long!';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() {
                        taskDesc = val;
                      });
                    },
                    maxLength: 512,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: Constants.kTextInputDecoration.copyWith(labelText: "Task Description", hintText: "e.g. I only eat organic bread."),
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
                        String err = await widget.team.createTask(taskName, taskDesc);
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
