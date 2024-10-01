part of 'track_bloc.dart';

@immutable
sealed class TrackState {}

final class TrackInitial extends TrackState {}

final class ReceivedState extends TrackState {}

final class PrepareState extends TrackState {}

final class ReadyState extends TrackState {}

final class ErrorState extends TrackState {}
