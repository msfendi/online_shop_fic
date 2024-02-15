part of 'top_rated_bloc.dart';

@freezed
class TopRatedEvent with _$TopRatedEvent {
  const factory TopRatedEvent.started() = _Started;
  const factory TopRatedEvent.getTopRated() = _GetTopRated;
}
