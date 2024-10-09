part of 'show_menu_cubit.dart';

@immutable
sealed class ShowMenuState {}

final class ShowMenuInitial extends ShowMenuState {}


final class ShowAllMenuState extends ShowMenuState {}

final class DelIthemState extends ShowMenuState {}
final class LodingState extends ShowMenuState {}
