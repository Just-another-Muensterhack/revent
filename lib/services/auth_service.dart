import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static init() {
    if (kIsWeb) {
      FirebaseAuth.instance.setPersistence(Persistence.SESSION);
    }
  }

  static Future<String> signInWithMail(String mail, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: mail,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
    return "success";
  }

  static Future<String> signUpWithMail(String mail, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: mail,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      print(e);
    }

    return "success";
  }

  static Future<void> signInWithGoogle() async {
    if (!kIsWeb) {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        throw Exception();
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } else {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      await FirebaseAuth.instance.signInWithPopup(googleProvider);
      //await FirebaseAuth.instance.signInWithRedirect(googleProvider);
    }
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static User? currentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  static bool currentUserExists() {
    return currentUser() != null;
  }
}
