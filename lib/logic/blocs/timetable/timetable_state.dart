part of 'timetable_bloc.dart';

sealed class TimetableState {}

final class TimetableInitial extends TimetableState {}

final class TimetableAdd extends TimetableState {}

final class TimetableLoaded extends TimetableState {}

final class TimetableError extends TimetableState {
  String message;
  TimetableError({required this.message});
}

final class TimetableLoading extends TimetableState {}
