import 'package:maw3ed/core/entities/event_model.dart';

abstract class EditEventRepo {
  Future<void> deleteEvent(EventModel event);
  Future<void> editEvent(EventModel event);
}
