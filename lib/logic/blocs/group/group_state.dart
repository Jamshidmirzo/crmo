part of 'group_bloc.dart';

sealed class GroupState {}

final class GroupInitial extends GroupState {}

final class GroupLoading extends GroupState {}

final class GroupsLoaded extends GroupState {}

final class GroupAdded extends GroupState {}

final class GroupError extends GroupState {
  String message;
  GroupError(this.message);
}
