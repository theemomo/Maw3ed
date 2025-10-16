part of 'add_event_cubit.dart';

abstract class AddEventState {}

class AddEventInitial extends AddEventState {}

class AddEventLoading extends AddEventState {}

class AddEventSuccess extends AddEventState {}

class AddEventFailure extends AddEventState {
  final String errorMessage;
  AddEventFailure(this.errorMessage);
}
