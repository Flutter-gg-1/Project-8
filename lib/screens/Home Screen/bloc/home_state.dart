part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
abstract class HomeBlocState {}

class HomeLoadingState extends HomeBlocState {}

class HomeLoadedState extends HomeBlocState {
  final List<ItemModel> products;
  HomeLoadedState(this.products);
}

class HomeErrorState extends HomeBlocState {
  final String error;
  HomeErrorState(this.error);
}
