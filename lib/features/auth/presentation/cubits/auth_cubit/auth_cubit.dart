import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maw3ed/features/auth/data/firebase_auth_repo.dart';
import 'package:maw3ed/features/auth/domain/entities/app_user.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final _firebaseAuth = FirebaseAuthRepo();
  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());
      final AppUser user = await _firebaseAuth.loginWithEmailAndPassword(
        email,
        password,
      );
      emit(Authenticated(user: user));
    } catch (e) {
      emit(AuthFailure(e is Exception ? e.toString().replaceFirst('Exception: ', '') : e.toString()));
    }
  }

  Future<void> register(String name, String email, String password) async {
    try {
      emit(AuthLoading());
      final AppUser user = await _firebaseAuth.registerWithEmailAndPassword(
        name,
        email,
        password,
      );
      emit(Authenticated(user: user));
    } catch (e) {
      emit(AuthFailure(e is Exception ? e.toString().replaceFirst('Exception: ', '') : e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      emit(AuthLoading());
      await _firebaseAuth.logout();
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> checkAuthStatus() async {
    final user = await _firebaseAuth.getCurrentUser();
    if (user != null) {
      emit(Authenticated(user: user));
    } else {
      emit(Unauthenticated());
    }
  }
}
