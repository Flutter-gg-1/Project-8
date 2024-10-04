part of 'menu_mgmt_cubit.dart';

@immutable
sealed class MenuMgmtState {}

final class MenuMgmtInitial extends MenuMgmtState {}

final class UpdateUIState extends MenuMgmtState {}

final class LoadingState extends MenuMgmtState {}
