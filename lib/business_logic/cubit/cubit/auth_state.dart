part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthLogedIn extends AuthState {
  final UserModel userModel;
  AuthLogedIn(this.userModel);
}

final class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

final class CodeSentState extends AuthState {
  final String verificationId;
  CodeSentState(this.verificationId);
}
