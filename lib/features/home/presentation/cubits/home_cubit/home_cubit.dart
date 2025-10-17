import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maw3ed/core/entities/event_model.dart';
import 'package:maw3ed/features/home/data/firebase_home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final FirebaseHomeRepo _firestore = FirebaseHomeRepo();
  Future<void> getTodayEvents() async {
    emit(FetchingEventsLoading());
    try {
      final todayEvents = await _firestore.getTodayEvents();
      emit(FetchingEventsLoaded(todayEvents));
    } catch (e) {
      emit(FetchingEventsError(e.toString()));
    }
  }

  Future<void> getEventsForSpecificDay(DateTime date) async {
    emit(FetchingEventsLoading());
    try {
      final events = await _firestore.getEventsForSpecificDay(date);
      emit(FetchingEventsLoaded(events));
    } catch (e) {
      emit(FetchingEventsError(e.toString()));
    }
  }
}
