part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoadingState extends AuthState {}

final class SuccessfulRegisterState extends AuthState {}

final class SuccessfulResentOTPState extends AuthState {}

final class SuccessfulVerifyState extends AuthState {}

final class SuccessfulLoginState extends AuthState {}

final class ErrorState extends AuthState {
  final String message;

  ErrorState({required this.message});
}
