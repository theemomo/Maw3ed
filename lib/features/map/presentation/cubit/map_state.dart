part of 'map_cubit.dart';

sealed class MapState {}

final class MapInitial extends MapState {}

final class GetEventsLoading extends MapState {}

final class GetEventsLoaded extends MapState {
  final List<EventModel> userEvents;
  GetEventsLoaded(this.userEvents);
}

final class GetEventsFailure extends MapState {
  final String errorMessage;
  GetEventsFailure(this.errorMessage);
}
