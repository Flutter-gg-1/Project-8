part of 'welcome_cubit.dart';

@immutable
sealed class WelcomeState {}

final class WelcomeInitial extends WelcomeState {}

final class ChangeDotsState extends WelcomeState {}