import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginVM extends ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: 'your-client_id.apps.googleusercontent.com',
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  GoogleSignInAccount? signInAccount;

  Future<void> signin() async {
    try {
      signInAccount = await _googleSignIn.signIn();
      print(signInAccount.toString());
    } catch (error) {
      print(error);
    }
  }
}
