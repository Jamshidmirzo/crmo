part of 'room_bloc.dart';

sealed class RoomState {
  const RoomState();
}

final class RoomInitial extends RoomState {}

final class RoomAdded extends RoomState {}

final class RoomLoaded extends RoomState {
  Map<String, dynamic> groups;
  RoomLoaded({required this.groups});
}

final class RoomLoading extends RoomState {}

final class RoomError extends RoomState {
  String message;
  RoomError({required this.message});
}
