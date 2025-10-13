import 'package:firebase_auth/firebase_auth.dart';
import 'package:maw3ed/features/auth/domain/entities/app_user_model.dart';
import 'package:maw3ed/features/auth/domain/repos/auth_repo.dart';

class FirebaseAuthRepo extends AuthRepo {
  final _auth = FirebaseAuth.instance;

  @override
  Future<AppUserModel?> getCurrentUser() async {
    if (_auth.currentUser != null) {
      final user = _auth.currentUser!;
      return AppUserModel(
        uid: user.uid,
        name: user.displayName ?? '',
        email: user.email ?? '',
      );
    }
    return null;
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
  }

  @override
  Future<AppUserModel> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AppUserModel(uid: user.user!.uid, email: user.user!.email!, name: '');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided.');
      } else {
        throw Exception('Login failed: ${e.message}');
      }
    }
  }

  @override
  Future<AppUserModel> registerWithEmailAndPassword(
    String name,
    String email,
    String password,
  ) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AppUserModel(uid: user.user!.uid, email: user.user!.email!, name: name);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw Exception('This email is already registered.');
        case 'invalid-email':
          throw Exception('The email address is invalid.');
        case 'weak-password':
          throw Exception('The password is too weak.');
        case 'operation-not-allowed':
          throw Exception('Email/password accounts are disabled.');
        default:
          throw Exception('Registration failed: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
