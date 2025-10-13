import 'package:maw3ed/features/add_event/domain/entities/add_event_model.dart';

abstract class AddEventRepo {
  Future<void> addEvent(AddEventModel newEvent);
}



