import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maw3ed/core/entities/event_model.dart';
import 'package:maw3ed/features/map/data/firebase_map_repo.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial());
  Future<void> getAllEvents() async {
    emit(GetEventsLoading());
    try {
      final List<EventModel> userEvents = await FirebaseMapRepo().getAllEvents();
      emit(GetEventsLoaded(userEvents));
    } catch (e) {
      emit(GetEventsFailure(e.toString()));
    }
  }
}
