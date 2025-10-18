part of 'event_details_cubit.dart';

sealed class EventDetailsState {}

final class EventDetailsInitial extends EventDetailsState {}

final class DeleteEventLoading extends EventDetailsState {}

final class EventDeleted extends EventDetailsState {}

final class DeleteEventFailure extends EventDetailsState {
  final String errorMessage;
  DeleteEventFailure(this.errorMessage);
}

final class UpdateEventLoading extends EventDetailsState {}

final class EventUpdated extends EventDetailsState {}

final class UpdateEventFailure extends EventDetailsState {
  final String errorMessage;
  UpdateEventFailure(this.errorMessage);
}
