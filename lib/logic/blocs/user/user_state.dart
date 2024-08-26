import 'package:crmo/data/models/admin.dart';
import 'package:crmo/data/models/student.dart';
import 'package:crmo/data/models/teacher_responce.dart';

sealed class UserState {
  const UserState();
}

final class UserInitial extends UserState {}

final class UserLoadingState extends UserState {}

final class UserGetState extends UserState {
  Map<String, dynamic> info;
  UserGetState({required this.info});
}

final class UserGetGroupsState extends UserState {
  Map<String, dynamic> info;
  UserGetGroupsState({required this.info});
}

final class UserGetTeacherState extends UserState {
  TeacherResponse info;
  UserGetTeacherState({required this.info});
}

final class UserGetAdminsState extends UserState {
  AdminResponse info;
  UserGetAdminsState({required this.info});
}

final class UserGetStudentsState extends UserState {
  StudentResponse info;
  UserGetStudentsState({required this.info});
}

final class UserErrorState extends UserState {
  String message;
  UserErrorState({required this.message});
}
