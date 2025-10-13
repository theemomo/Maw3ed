part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class Authenticated extends AuthState {
  final AppUserModel user;
  Authenticated({required this.user});
}

final class Unauthenticated extends AuthState {}

final class AuthFailure extends AuthState {
  final String errorMessage;
  AuthFailure(this.errorMessage);
}
