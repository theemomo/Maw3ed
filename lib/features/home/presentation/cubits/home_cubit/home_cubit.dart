import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maw3ed/features/add_event/domain/entities/event_model.dart';
import 'package:maw3ed/features/home/data/firebase_home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> getTodayEvents() async {
    emit(FetchingTodayLoading());
    try {
      final events = await FirebaseHomeRepo().getTodayEvents();
      emit(FetchingTodayLoaded(events));
    } catch (e) {
      emit(FetchingTodayError(e.toString()));
    }
  }
}
