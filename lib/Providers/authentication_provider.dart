import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../firebase_options.dart';

class AuthProvider extends ChangeNotifier {

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn(clientId: DefaultFirebaseOptions.currentPlatform.androidClientId).signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser
        ?.authentication;

    // Create a new credential
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<bool> logout() async {
    try {
      await FirebaseAuth.instance.signOut();

      GoogleSignIn(
          clientId: DefaultFirebaseOptions.currentPlatform.androidClientId)
          .signOut;

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
