part of 'track_bloc.dart';

@immutable
sealed class TrackEvent {}

final class ReceivedEvent extends TrackEvent {}

final class PrepareEvent extends TrackEvent {}

final class ReadyEvent extends TrackEvent {}
