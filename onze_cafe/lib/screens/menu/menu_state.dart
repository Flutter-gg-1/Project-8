part of 'menu_cubit.dart';

@immutable
sealed class MenuState {}

final class MenuInitial extends MenuState {}

final class UpdateUIState extends MenuState {}

final class SuccessState extends MenuState {}

final class ErrorState extends MenuState {}
