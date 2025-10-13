import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_event_state.dart';

class AddEventCubit extends Cubit<AddEventState> {
  AddEventCubit() : super(AddEventInitial());
}
