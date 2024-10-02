part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class SucessState extends AuthState {}

final class ErrorState extends AuthState {
  final String msg;

  ErrorState({required this.msg});
}

final class LoadingState extends AuthState {}

final class NoLoadingState extends AuthState {}
