import 'package:maw3ed/features/auth/domain/entities/app_user_model.dart';

abstract class AuthRepo {
  Future<AppUserModel?> getCurrentUser();
  Future<AppUserModel?> loginWithEmailAndPassword(String email, String password);
  Future<AppUserModel?> registerWithEmailAndPassword(
    String name,
    String email,
    String password,
  );
  Future<void> logout();
}
