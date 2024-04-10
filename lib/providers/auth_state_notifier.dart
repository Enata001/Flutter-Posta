import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:posta/features/authentication/models/auth_result.dart';
import 'package:posta/features/authentication/models/auth_state.dart';
import 'package:posta/models/user_model.dart';
import 'package:posta/services/firebase_auth_methods.dart';
import 'package:posta/services/firebase_firestore_methods.dart';
import 'package:posta/services/firebase_storage_methods.dart';
import 'package:posta/utils/typedefs.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _auth = FirebaseAuthMethods();

  AuthStateNotifier() : super(const AuthState.loggedOut()) {
    if (_auth.isLoggedIn) {
      state = AuthState(
        isLoading: false,
        result: AuthResult.success,
        userId: _auth.userId,
      );
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String username,
    Uint8List? file,
  }) async {
    state = state.copiedWithIsLoading(true);
    final result = await _auth.signUp(
      email: email,
      username: username,
      password: password,
    );
    if (result == AuthResult.success && _auth.userId != null) {
      final photoLink = await FirebaseStorageMethods().uploadPicture(
        file: file,
        userId: _auth.userId!,
      );
      await FirestoreMethods().storeUserInfo(
        user: UserModel(
          username: username,
          userId: _auth.userId,
          email: email,
          photoLink: photoLink,
        ),
      );
    }

    state = AuthState.success(_auth.userId);
  }

  Future<void> signInWithCredentials({
    required String email,
    required String password,
  }) async {
    state = state.copiedWithIsLoading(true);
    final result = await _auth.signIn(
      email: email,
      password: password,
    );
    if (result == AuthResult.success && _auth.userId != null) {
      state = AuthState.success(_auth.userId);
    }
  }

  Future<void> signInWithGoogle() async {
    state = state.copiedWithIsLoading(true);
    final result = await _auth.signInWithGoogle();
    if (result == AuthResult.success && _auth.userId != null) {
      final photoLink = await FirebaseStorageMethods().uploadPicture(
        userId: _auth.userId!,
      );
      await FirestoreMethods().storeUserInfo(
        user: UserModel(
          username: _auth.displayName,
          userId: _auth.userId,
          email: _auth.email ?? "",
          photoLink: photoLink,
        ),
      );
    }

    state = AuthState.success(_auth.userId);
  }

  Future<void> signOut() async {
    state = state.copiedWithIsLoading(true);
    await _auth.signOut();
    state = const AuthState.loggedOut();
  }
}

class AuthProvider extends ChangeNotifier {
  final _auth = FirebaseAuthMethods();

  AuthState state = const AuthState.loggedOut();

  AuthProvider() {
    if (_auth.isLoggedIn) {
      state = AuthState(
          result: AuthResult.success, isLoading: false, userId: _auth.userId);
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String username,
    Uint8List? file,
  }) async {
    state = state.copiedWithIsLoading(true);
    final result = await _auth.signUp(
      email: email,
      username: username,
      password: password,
    );
    if (result == AuthResult.success && _auth.userId != null) {
      final photoLink = await FirebaseStorageMethods().uploadPicture(
        file: file,
        userId: _auth.userId!,
      );
      await FirestoreMethods().storeUserInfo(
        user: UserModel(
          username: username,
          userId: _auth.userId,
          email: email,
          photoLink: photoLink,
        ),
      );
    }
    state = AuthState.success(
      _auth.userId,
    );
    notifyListeners();
  }

  Future<void> signInWithCredentials({
    required String email,
    required String password,
  }) async {
    state = state.copiedWithIsLoading(true);
    final result = await _auth.signIn(
      email: email,
      password: password,
    );
    if (result == AuthResult.success && _auth.userId != null) {
      state = AuthState.success(_auth.userId);
    }
    notifyListeners();
  }

  Future<void> signInWithGoogle() async {
    state = state.copiedWithIsLoading(true);
    final result = await _auth.signInWithGoogle();
    if (result == AuthResult.success && _auth.userId != null) {
      final photoLink = await FirebaseStorageMethods().uploadPicture(
        userId: _auth.userId!,
      );
      await FirestoreMethods().storeUserInfo(
        user: UserModel(
            username: _auth.displayName,
            userId: _auth.userId,
            email: _auth.email ?? "",
            photoLink: photoLink),
      );
    }

    state = AuthState.success(_auth.userId);
    notifyListeners();
  }

  // Future<void> signInWithFacebook() async {
  //   state = state.copiedWithIsLoading(true);
  //   final result = await _auth.signInWithFacebook();
  //   if (result == AuthResult.success && _auth.userId != null) {
  //     final photoLink =
  //         await FirebaseStorageMethods().uploadPicture(userId: _auth.userId!);
  //     await FirestoreMethods().storeUserInfo(
  //         user: UserModel(
  //             username: _auth.displayName,
  //             userId: _auth.userId,
  //             email: _auth.email ?? "",
  //             photoLink: photoLink));
  //   }
  //
  //   state = AuthState.success(_auth.userId);
  //   notifyListeners();
  // }

  Future<void> signOut() async {
    state = state.copiedWithIsLoading(true);
    await _auth.signOut();
    state = const AuthState.loggedOut();
    notifyListeners();
  }
}

final authStateNotifierProvider =
    StateNotifierProvider<AuthStateNotifier, AuthState>(
  (ref) => AuthStateNotifier(),
);

final authStateProvider = ChangeNotifierProvider<AuthProvider>(
  (ref) => AuthProvider(),
);

final userIdProvider =
    Provider<UserId?>((ref) => ref.watch(authStateProvider).state.userId);

final userIdNotifierProvider = Provider<UserId?>((ref) {
  // return FirebaseAuthMethods().userId;
  final authState = ref.watch(authStateNotifierProvider);
  return authState.userId;
});

final isLoggedInNotifierProvider = Provider<bool>((ref) {
  // return FirebaseAuthMethods().isLoggedIn;

  final authState = ref.watch(authStateNotifierProvider);
  return authState.result == AuthResult.success;
});

final isLoggedInProvider = Provider<bool>(
  (ref) => ref.watch(authStateProvider).state.isLoading,
);
