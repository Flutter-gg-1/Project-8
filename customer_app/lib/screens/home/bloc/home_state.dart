part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class SearchSuccessFoundState extends HomeState {}

final class SearchResultNotFoundState extends HomeState {}

final class LoadingState extends HomeState {}

final class SearchScreenErrorState extends HomeState {
  final String msg;

  SearchScreenErrorState({required this.msg});
}
