// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'group_bloc.dart';

sealed class GroupEvent {}

class GroupAddEvent extends GroupEvent {
  String name;
  int teacherId;
  // ignore: non_constant_identifier_names
  int assitant_teacher_id;
  GroupAddEvent({
    required this.name,
    required this.teacherId,
    // ignore: non_constant_identifier_names
    required this.assitant_teacher_id,
  });
}

class GroupGetEvent extends GroupEvent {}

class GroupAddedStudnetsEvent extends GroupEvent {
  List students;
  int groupId;
  GroupAddedStudnetsEvent({
    required this.students,
    required this.groupId,
  });
}
