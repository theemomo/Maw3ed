part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class FetchingEventsLoading extends HomeState {}

final class FetchingEventsLoaded extends HomeState {
  final List<EventModel> events;
  FetchingEventsLoaded(this.events);
}

final class FetchingEventsError extends HomeState {
  final String message;
  FetchingEventsError(this.message);
}
