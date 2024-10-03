part of 'landing_cubit.dart';

@immutable
sealed class LandingState {}

final class LandingInitial extends LandingState {}

class RegularUserState extends LandingState {}

class EmployeeUserState extends LandingState {}
