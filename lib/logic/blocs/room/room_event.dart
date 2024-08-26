// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'room_bloc.dart';

sealed class RoomEvent {
  const RoomEvent();
}

class RoomAddEvent extends RoomEvent {
  String name;
  String desc;
  int capacity;
  RoomAddEvent({
    required this.name,
    required this.desc,
    required this.capacity,
  });
}

class RoomLoadedEvent extends RoomEvent {}

class RoomDeleteEvent extends RoomEvent {
  int id;
  RoomDeleteEvent({
    required this.id,
  });
}
