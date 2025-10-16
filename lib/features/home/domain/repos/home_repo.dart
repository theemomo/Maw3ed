import 'package:maw3ed/core/entities/event_model.dart';

abstract class HomeRepo {
  Future<List<EventModel>> getTodayEvents();
}
