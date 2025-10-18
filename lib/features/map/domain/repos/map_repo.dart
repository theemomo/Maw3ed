import 'package:maw3ed/core/entities/event_model.dart';

abstract class MapRepo {
  Future<List<EventModel>> getAllEvents();
}
