part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class SucssState extends AuthState {}

final class EorrState extends AuthState {
  final String msg;

  EorrState({required this.msg});
}

final class LodingState extends AuthState {}

final class NoLodingState extends AuthState {}
