import 'package:best_starter_architecture/models/custom_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  CustomUser _userFromFirebaseUser(User firebaseUser) => firebaseUser == null
      ? null
      : CustomUser(
          uid: firebaseUser.uid,
          name: firebaseUser.displayName,
          email: firebaseUser.email,
        );
  // Stream<CustomUser> get user => _auth
  //     .authStateChanges()
  //     .map((User firebaseUser) => _userFromFirebaseUser(firebaseUser));
  Stream<CustomUser> get onAuthStateChanges =>
      _auth.authStateChanges().map(_userFromFirebaseUser);

  Future signOut() async => await _auth.signOut();

  Future<CustomUser> signInAnon() async {
    try {
      final UserCredential _credentials = await _auth.signInAnonymously();
      return _userFromFirebaseUser(_credentials.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<CustomUser> registerWithEmailAndPassword(
      {String email, String password}) async {
    try {
      final UserCredential _credentials = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return _userFromFirebaseUser(_credentials.user);
    } catch (e) {
      return null;
    }
  }

  Future<CustomUser> signInWithEmailAndPassword(
      {String email, String password}) async {
    try {
      final UserCredential _credentials = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      return _userFromFirebaseUser(_credentials.user);
    } catch (e) {
      return null;
    }
  }
}
