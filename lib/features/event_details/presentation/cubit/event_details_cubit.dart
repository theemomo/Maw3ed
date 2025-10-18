import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maw3ed/core/entities/event_model.dart';
import 'package:maw3ed/features/event_details/data/firebase_edit_repo.dart';

part 'event_details_state.dart';

class EventDetailsCubit extends Cubit<EventDetailsState> {
  EventDetailsCubit() : super(EventDetailsInitial());
  final FirebaseEditRepo _firestore = FirebaseEditRepo();

  Future<void> deleteEvent(EventModel event) async {
    emit(DeleteEventLoading());
    try {
      await _firestore.deleteEvent(event);
      emit(EventDeleted());
    } catch (e) {
      emit(DeleteEventFailure(e.toString()));
    }
  }
}
