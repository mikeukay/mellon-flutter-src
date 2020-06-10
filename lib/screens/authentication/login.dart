import 'package:flutter/material.dart';
import 'package:mellon/services/auth.dart';
import 'package:mellon/shared/loading_widget.dart';
import '../../shared/constants.dart';

class LoginScreen extends StatefulWidget {

  final Function toggleView;

  LoginScreen({this.toggleView});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final AuthenticationService _auth = AuthenticationService();
  final _formKey = GlobalKey<FormState>();

  String error = "";
  String email = "";
  String password = "";

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.width;
    double width = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Log in to Mellon'),
      ),
      body: loading ? LoadingWidget() : Padding(
        padding: EdgeInsets.fromLTRB(width * 0.05, height * 0.07, width * 0.05, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                validator: (val) =>  val.isEmpty ? 'Please enter an email' : null,
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
                decoration: Constants.kTextInputDecoration.copyWith(hintText: 'Email'),
              ),
              SizedBox(height: height * 0.05),
              TextFormField(
                obscureText: true,
                validator: (val) =>  val.length< 7 ? 'Ya password\'s too short' : null,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
                decoration: Constants.kTextInputDecoration.copyWith(hintText: 'Password'),
              ),
              SizedBox(height: height * 0.05),
              RaisedButton(
                color: Constants.kPrimaryColor,
                child: Text(
                  'Log in',
                  style: TextStyle(
                    color: Constants.kBackgroundColor,
                  ),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()) {
                    setState(() => loading = true);
                    dynamic result = await _auth.loginWithEmailAndPassword(email, password);
                    if(result == null) {
                      setState(() {
                        loading = false;
                        error = "Invalid login details :(";
                      });
                    }
                  }
                },
              ),
              SizedBox(height: width * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      color: Constants.kCommentColor,
                      fontSize: width * 0.016,
                    ),
                  ),
                  SizedBox(width: width * 0.005),
                  InkWell(
                    child: Text(
                      'Register one.',
                      style: TextStyle(
                        color: Constants.kCommentColor,
                        fontSize: width * 0.016,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: widget.toggleView,
                  ),
                ],
              ),
              SizedBox(height: width * 0.02),
              Text(
                error,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
