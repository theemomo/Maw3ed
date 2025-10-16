import 'package:maw3ed/core/entities/event_model.dart';

abstract class AddEventRepo {
  Future<void> addEvent(EventModel newEvent);
}



