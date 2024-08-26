// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
part of 'timetable_bloc.dart';

sealed class TimetableEvent {
  const TimetableEvent();
}

class TimetableAddEvent extends TimetableEvent {
   int group_id;
  int room_id;
  int day_id;
  String start_time;
  String end_time;
  TimetableAddEvent({
    required this.group_id,
    required this.room_id,
    required this.day_id,
    required this.start_time,
    required this.end_time,
  });
  
  
}
