import 'dart:core';
import 'dart:io';

sealed class UserEvent {}

class GetUserEvent extends UserEvent {}

class GetTeacherEvent extends UserEvent {}

class GetStundetsEvent extends UserEvent {}

class GetAdminsEvent extends UserEvent {}
class GetGroupsEvent extends UserEvent {}



class UpdateInfoUserEvent extends UserEvent {
  final String? name;
  final String? email;
  final String phone;
  final File? photo;

  UpdateInfoUserEvent({
    this.name,
    this.email,
    required this.phone,
    this.photo,
  });
}
