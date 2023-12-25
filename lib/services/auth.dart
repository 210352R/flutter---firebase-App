// import firebase auth package
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_app/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FireBaseUser? _userFromFirebaseUser(User? user) {
    return user != null ? FireBaseUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<FireBaseUser?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user));
  }

  // sign in anon
  Future signInAnon() async {
    try {
      // use the auth instance to sign in anonymously
      UserCredential result = await _auth.signInAnonymously();
      // get the user from the result
      User? user = result.user;
      // return the user
      FireBaseUser? firebaseUser = _userFromFirebaseUser(user);
      print("wade goda");
      return firebaseUser;
    } catch (e) {
      print("Error in signInAnon");
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      print(user);
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      print(
          "Registering user with email and password Done ----------------------");
      print(user);
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    // use the auth instance to sign out
    try {
      return await _auth.signOut();
    } catch (e) {
      print("Error in signOut");
      print(e.toString());
      return null;
    }
  }
}
