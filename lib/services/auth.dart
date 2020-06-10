import 'package:firebase_auth/firebase_auth.dart';
import 'package:mellon/models/user.dart';

class AuthenticationService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // register
  Future<User> registerWithEmailAndPassword(email, password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _firebaseUserToUser(user);
    } catch(e) {
      return null;
    }
  }

  // login
  Future<User> loginWithEmailAndPassword(email, password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _firebaseUserToUser(user);
    } catch(e) {
      return null;
    }
  }

  // logout
  Future<void> logOut() async {
    await _auth.signOut();
  }

  User _firebaseUserToUser(FirebaseUser user) {
    return user== null ? null : User(uid: user.uid, email: user.email);
  }

  Stream<User> get authStream {
    return _auth.onAuthStateChanged.map(_firebaseUserToUser);
  }

}