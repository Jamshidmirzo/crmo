import 'package:bloc/bloc.dart';
import 'package:crmo/logic/services/time_table_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'timetable_event.dart';
part 'timetable_state.dart';

class TimetableBloc extends Bloc<TimetableEvent, TimetableState> {
  TimetableBloc() : super(TimetableInitial()) {
    on<TimetableEvent>((event, emit) {});
    on<TimetableAddEvent>(_addTimeTable);
  }

  TimeTableService timeTableService = TimeTableService();
  _addTimeTable(TimetableAddEvent event, emit) async {
    try {
      final shared = await SharedPreferences.getInstance();
      final token = shared.getString('token');
      if (token == null) {
        return;
      }
      timeTableService.createTimeTable(event.group_id, event.room_id,
          event.day_id, event.start_time, event.end_time, token);
    } catch (e) {
      emit(
        TimetableError(
          message: e.toString(),
        ),
      );
    }
  }
}
