import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:mellon/models/task.dart';
import 'package:mellon/models/team.dart';
import 'package:mellon/models/team_member.dart';
import 'package:mellon/models/user.dart';

class DatabaseService {
  String uid;
  String teamId;

  DatabaseService({this.uid, this.teamId});

  final db = Firestore.instance;

  List<Team> _userToTeamList(DocumentSnapshot snap) {
    List<Team> list = new List<Team>();
    dynamic teams = snap.data['teams'];
    teams.forEach((key, value) {
      list.add(Team(id: key, name: value['name'], description: value['description'], admin: value['admin']));
    });
    return list;
  }

  Stream<List<Team>> getUserTeams() {
    return db.collection('users').document(uid).snapshots().map(_userToTeamList);
  }

  Future<String> createTeam(String name, String desc, User creator) async {
    await db.collection('teams').add({
      'name': name,
      'description': desc,
      'members': {
        creator.uid: {
          'email': creator.email,
          'admin': true
        }
      }
    }).catchError((error) {
      return error.toString();
    });
    return '';
  }

  List<TeamMember> _teamToMemberList(DocumentSnapshot snap) {
    List<TeamMember> list = new List<TeamMember>();
    dynamic members = snap.data['members'];
    members.forEach((key, value) {
      list.add(TeamMember(uid: key, teamId: snap.documentID, email: value['email'], admin: value['admin']));
    });
    return list;
  }

  Stream<List<TeamMember>> getTeamMembers(String teamId) {
    return db.collection('teams').document(teamId).snapshots().map(_teamToMemberList);
  }

  Future<String> editTeam(String teamId, String newTeamName, String newTeamDesc) async {
    await db.collection('teams').document(teamId).setData({
      'name': newTeamName,
      'description': newTeamDesc,
    }, merge: true).catchError((err) {
      return err.toString();
    });
    return '';
  }

  Future<String> addTeamMember(String email, String teamId) async {
    final HttpsCallable getUidFromEmail = CloudFunctions.instance.getHttpsCallable(functionName: 'getUidFromEmail')
      ..timeout = const Duration(seconds: 30);
    try {
      final HttpsCallableResult res = await getUidFromEmail.call({
        'email': email
      });
      String uid = res.data;
      if(uid != '') {
        Map<String, dynamic> newMember = {
          uid: {'email': email, 'admin': false}
        };
        await db.collection('teams').document(teamId).setData({
          'members': newMember
        }, merge: true);
        return '';
      }
      return 'no uid returned';
    } catch(err) {
      return err.toString();
    }

  }

  Future<void> removeTeamMember(String uid, String teamId) async {
    await db.runTransaction((t) {
      return t.get(db.collection('teams').document(teamId)).then((doc) {
        if(!doc.exists) {
          return '';
        }
        var members = doc.data['members'];
        members.remove(uid);
        return t.update(db.collection('teams').document(teamId), {
          'members': members
        });
      });
    });
  }

  Future<void> makeTeamMemberAdmin(String uid, String teamId) async {
    await db.runTransaction((t) {
      return t.get(db.collection('teams').document(teamId)).then((doc) {
        if(!doc.exists) {
          return '';
        }
        var members = doc.data['members'];
        members[uid]['admin'] = true;
        return t.update(db.collection('teams').document(teamId), {
          'members': members
        });
      });
    });
  }

  Future<void> revokeTeamMemberAdmin(String uid, String teamId) async {
    await db.runTransaction((t) {
      return t.get(db.collection('teams').document(teamId)).then((doc) {
        if(!doc.exists) {
          return '';
        }
        var members = doc.data['members'];
        members[uid]['admin'] = false;
        return t.update(db.collection('teams').document(teamId), {
          'members': members
        });
      });
    });
  }

  Future<void> deleteTeam(String teamId) async {
    await db.collection('teams').document(teamId).delete();
  }

  List<Task> _tasksToTaskList(QuerySnapshot snap) {
    List<Task> list = new List<Task>();
    dynamic teams = snap.documents;
    teams.forEach((doc) {
      list.add(Task(teamId: teamId, taskId: doc.documentID, name: doc.data['name'], description: doc.data['description'], completed: doc.data['completed'], started: doc.data['started']));
    });
    return list;
  }

  Stream<List<Task>> getTeamTasks(String aTeamId) {
    teamId = aTeamId;
    return db.collection('teams').document(teamId).collection('tasks').snapshots().map(_tasksToTaskList);
  }

  Future<String> createTaskForTeam(String teamId, String taskName, String taskDesc) async {
    try {
      await db.collection('teams').document(teamId).collection('tasks').add({
        'name': taskName,
        'description': taskDesc,
        'started': false,
        'completed': false
      });
      return '';
    } catch(e) {
      return e.toString();
    }
  }

  Future<void> updateTask(String teamId, String taskId, String taskName, String taskDesc, bool started, bool completed) async {
    await db.collection('teams').document(teamId).collection('tasks').document(taskId).updateData({
      'started': started,
      'completed': completed,
      'name': taskName,
      'description': taskDesc
    });
  }

  Future<void> deleteTask(String teamId, String taskId) async {
    await db.collection('teams').document(teamId).collection('tasks').document(taskId).delete();
  }

}