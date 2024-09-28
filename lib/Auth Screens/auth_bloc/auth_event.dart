part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class RegisterEvent extends AuthEvent {
  final String email;
  final String password;

  RegisterEvent({required this.email, required this.password});
}

final class VerifyEvent extends AuthEvent {
  final String email;
  final String password;
  final String otp;

  VerifyEvent({required this.email,required this.password, required this.otp});
}



final class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}
