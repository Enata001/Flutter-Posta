import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:posta/features/authentication/models/auth_result.dart';
import 'package:posta/utils/constants.dart';
import 'package:posta/utils/typedefs.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserId? get userId => _auth.currentUser?.uid;

  bool get isLoggedIn => userId != null;

  String get displayName => _auth.currentUser?.displayName ?? "";

  String? get email => _auth.currentUser?.email;

  Future<void> signOut() async {
    await _auth.signOut();
    await FacebookAuth.instance.logOut();
    await GoogleSignIn().signOut();
  }

  Future<AuthResult> signUp({
    required String email,
    required String username,
    required String password,
  }) async {
    if (email.isEmpty ||
        password.isEmpty ||
        password.length < 8 ||
        username.isEmpty ||
        username.length < 6) {
      return AuthResult.aborted;
    }

    final authCredential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );

    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return AuthResult.success;
    } on FirebaseAuthException catch (e) {
      final email = e.email;
      final credential = e.credential;
      if (e.code == Constants.emailExists &&
          email != null &&
          credential != null) {
        QuerySnapshot query = await FirebaseFirestore.instance
            .collection('users')
            .where(
              "email",
              isEqualTo: email,
            )
            .get();

        if (query.docs.isNotEmpty &&
            query.docs.first.data().toString().contains("google.com")) {
          await signInWithGoogle();
          await _auth.currentUser?.linkWithCredential(
            authCredential,
          );
        }
        return AuthResult.success;
      }
      return AuthResult.failure;
    }
  }

  Future<AuthResult> signIn({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty || password.length < 8) {
      return AuthResult.aborted;
    }
    final authCredential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );
    try {
      await _auth.signInWithCredential(authCredential);
      return AuthResult.success;
    } on FirebaseAuthException {
      return AuthResult.failure;
    }
  }

  // Future<AuthResult> signInWithFacebook() async {
  //   final loginResult = await FacebookAuth.instance.login();
  //   final token = loginResult.accessToken?.token;
  //   if (token == null) {
  //     return AuthResult.aborted;
  //   }
  //
  //   final authCredential = FacebookAuthProvider.credential(token);
  //
  //   try {
  //     await _auth.signInWithCredential(authCredential);
  //     return AuthResult.success;
  //   } on FirebaseAuthException catch (e) {
  //     final email = e.email;
  //     final credential = e.credential;
  //     if (e.code == Constants.emailExists &&
  //         email != null &&
  //         credential != null) {
  //       QuerySnapshot query = await FirebaseFirestore.instance
  //           .collection('users')
  //           .where("email", isEqualTo: email)
  //           .get();
  //
  //       if (query.docs.isNotEmpty &&
  //           query.docs.first.data().toString().contains("google.com")) {
  //         await signInWithGoogle();
  //         await _auth.currentUser?.linkWithCredential(authCredential);
  //       }
  //       return AuthResult.success;
  //     }
  //     return AuthResult.failure;
  //   }
  // }

  Future<AuthResult> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();

    if (googleAccount == null) {
      return AuthResult.aborted;
    }

    final googleAuth = await googleAccount.authentication;
    final authCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      await _auth.signInWithCredential(authCredential);
      return AuthResult.success;
    } on FirebaseException {
      return AuthResult.failure;
    }
  }
}
