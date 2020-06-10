import 'package:flutter/material.dart';
import 'package:mellon/models/user.dart';
import 'package:mellon/screens/authentication/authenticate.dart';
import 'package:mellon/screens/teams/teams.dart';
import 'package:provider/provider.dart';

class WrapperScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    if(user == null) {
      return AuthenticationScreen();
    } else {
      return TeamsScreen();
    }
  }
}
