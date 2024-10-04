part of 'add_offer_cubit.dart';

@immutable
sealed class AddOfferState {}

final class AddOfferInitial extends AddOfferState {}

final class UpdateUIState extends AddOfferState {}

final class LoadingState extends AddOfferState {}
