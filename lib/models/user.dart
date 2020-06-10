import 'package:mellon/models/team.dart';
import 'package:mellon/services/database.dart';

class User {
  String uid;
  String email;

  User({this.uid, this.email});

  Stream<List<Team>> get teams {
    return DatabaseService(uid: uid).getUserTeams();
  }
}