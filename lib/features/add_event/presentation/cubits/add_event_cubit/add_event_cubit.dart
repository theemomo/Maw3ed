import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:maw3ed/features/add_event/data/firebase_add_event_repo.dart';
import 'package:maw3ed/core/entities/event_model.dart';
import 'package:maw3ed/features/add_event/data/local_notification_repo.dart';
import 'package:maw3ed/generated/l10n.dart';

part 'add_event_state.dart';

class AddEventCubit extends Cubit<AddEventState> {
  AddEventCubit() : super(AddEventInitial());
  Future<void> addEvent(
    String title,
    String description,
    DateTime? date,
    TimeOfDay? time,
    LatLng? location,
    BuildContext context
  ) async {
    emit(AddEventLoading());
    try {
      final now = DateTime.now();

      final eventDateTime = DateTime(
        date!.year,
        date.month,
        date.day,
        time!.hour,
        time.minute,
      );

      if (eventDateTime.isBefore(now)) {
        throw Exception(S.of(context).eventMustBeInFuture);
      }

      final EventModel newEvent = EventModel(
        title: title,
        description: description,
        date: date,
        time: time,
        location: location!,
      );
      await FirebaseAddEventRepo().addEvent(newEvent);
      await LocalNotificationRepo.showScheduledNotificationAtASpecificTime(
        title,
        description,
        eventDateTime
      );
      emit(AddEventSuccess());
    } catch (e) {
      emit(AddEventFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> notification() async {}
}
