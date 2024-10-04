part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeLoadedState extends HomeState {
  final List<ItemModel> products;
  HomeLoadedState(this.products);
}

final class UpdateCartCountState extends HomeState {
  final int count;
  UpdateCartCountState({required this.count});
}

final class ErrorState extends HomeState {
  final String error;
  ErrorState(this.error);
}
