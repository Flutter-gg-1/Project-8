part of 'add_category_cubit.dart';

@immutable
sealed class AddCategoryState {}

final class AddCategoryInitial extends AddCategoryState {}

final class UpdateUIState extends AddCategoryState {}

final class LoadingState extends AddCategoryState {}
