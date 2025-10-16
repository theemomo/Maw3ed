part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class FetchingTodayLoading extends HomeState {}

final class FetchingTodayLoaded extends HomeState {
  final List<EventModel> events;
  FetchingTodayLoaded(this.events);
}

final class FetchingTodayError extends HomeState {
  final String message;
  FetchingTodayError(this.message);
}
