part of 'subject_bloc.dart';

sealed class SubjectState {}

final class SubjectInitial extends SubjectState {}

final class SubjectLoaded extends SubjectState {
  Map<String, dynamic> subjects;
  SubjectLoaded({required this.subjects});
}

final class SubjectLoadind extends SubjectState {}

final class SubjectError extends SubjectState {
  String message;
  SubjectError({required this.message});
}
