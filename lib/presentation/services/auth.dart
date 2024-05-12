import 'package:exercise_app/presentation/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Authservice {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<User?> get user {
    return _auth.authStateChanges();
  }


  Future sigout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  //sign in with email and password
  Future signinwithemailandpassword(String email, String password) async {
    try {
        await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);


    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register using email and password
  Future registerwithemailandpassword(
      String email, String password, String name, String height , String weight ,String level,String gender) async {
    try {

      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      User? user = result.user;
         await user!.getIdToken();
      //create a document in firestore
      await DatabaseService().insertuserdata(name, height , weight ,level,gender);

    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //reset the password
  Future passwordreset(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email.trim());
    } catch (e) {}
  }
}
