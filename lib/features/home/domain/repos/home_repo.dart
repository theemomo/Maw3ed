import 'package:maw3ed/features/add_event/domain/entities/event_model.dart';

abstract class HomeRepo {
  Future<List<EventModel>> getTodayEvents();
}
