import 'package:maw3ed/features/auth/domain/entities/app_user.dart';

abstract class AuthRepo {
  Future<AppUser?> getCurrentUser();
  Future<AppUser?> loginWithEmailAndPassword(String email, String password);
  Future<AppUser?> registerWithEmailAndPassword(
    String name,
    String email,
    String password,
  );
  Future<void> logout();
}
