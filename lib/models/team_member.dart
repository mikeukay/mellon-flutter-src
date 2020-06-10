import 'package:mellon/services/database.dart';

class TeamMember {
  String uid;
  String teamId;
  String email;
  bool admin;

  TeamMember({this.uid, this.teamId, this.email, this.admin});

  Future<void> kick() async {
    await DatabaseService().removeTeamMember(uid, teamId);
  }

  Future<void> makeAdmin() async {
    await DatabaseService().makeTeamMemberAdmin(uid, teamId);
  }

  Future<void> revokeAdmin() async {
    await DatabaseService().revokeTeamMemberAdmin(uid, teamId);
  }

  Future<void> deleteTeam() async {
    await DatabaseService().deleteTeam(teamId);
  }

}