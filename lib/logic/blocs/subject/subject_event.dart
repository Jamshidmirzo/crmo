part of 'subject_bloc.dart';

sealed class SubjectEvent {}

class SubjectAddEvent extends SubjectEvent {
  String name;
  SubjectAddEvent({required this.name});
}

class SubjectGetEvent extends SubjectEvent {}

class SubjectDeleteEvent extends SubjectEvent {
  int id;
  SubjectDeleteEvent({required this.id});
}
