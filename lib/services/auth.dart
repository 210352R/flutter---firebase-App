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
