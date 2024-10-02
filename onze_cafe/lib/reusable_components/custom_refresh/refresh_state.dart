part of 'refresh_cubit.dart';

@immutable
sealed class RefreshState {}

final class RefreshInitial extends RefreshState {}
class RefreshLoading extends RefreshState {}

class SuccessRefresh extends RefreshState {}

class ErrorRefresh extends RefreshState {}
