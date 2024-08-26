part of 'group_bloc.dart';

sealed class GroupState {}

final class GroupInitial extends GroupState {}

final class GroupLoading extends GroupState {}

final class GroupsLoaded extends GroupState {
  Map<String,dynamic> groups;
  GroupsLoaded({required this.groups});
}

final class GroupAdded extends GroupState {}

final class GroupError extends GroupState {
  String message;
  GroupError(this.message);
}
