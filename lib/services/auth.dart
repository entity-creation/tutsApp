import 'package:firebase_auth/firebase_auth.dart';
import 'package:tuts_app/models/user.dart';
import 'package:tuts_app/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on firebase user
  Tester? _userFromFirebaseUser(User? user) {
    return user != null ? Tester(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<Tester?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //sign in with email and password
  Future pass(
    final emailController,
    final passwordController,
  ) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: emailController, password: passwordController);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register
  Future registerForm(
    dynamic gender,
    dynamic school,
    final emailController,
    final passwordController,
    final nameController,
    final numberController,
    final addressController,
  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: emailController, password: passwordController);
      User? user = result.user;

      await DatabaseService(uid: user!.uid).updateUserData(
          nameController,
          numberController,
          addressController,
          gender,
          school,
          'image',
          DateTime.utc(2000),
          ['Physics', 'Chemistry', 'Biology'],
          ['Physics', 'Chemistry', 'Biology']);

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
