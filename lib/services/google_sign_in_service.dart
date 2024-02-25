import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  UserCredential? userCredential;

  Future<UserCredential?> googleSignIn() async {
    debugPrint(" :: here 0");

    final GoogleSignInAccount? googleSignInAccount =
        await GoogleSignIn().signIn();

    try {
      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;

      debugPrint(" :: here 1");

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );

      var userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      debugPrint(userCredential.user.toString());
    } catch (e) {
      debugPrint(" :: here 2 $e");
    }
    return userCredential;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
