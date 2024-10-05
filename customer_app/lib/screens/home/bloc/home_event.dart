part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class SearchEvent extends HomeEvent {
  final String searchValue;

  SearchEvent({required this.searchValue});
}
