import 'package:bloc/bloc.dart';
import 'package:crmo/logic/services/room_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'room_event.dart';
part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  RoomService roomService = RoomService();
  RoomBloc() : super(RoomInitial()) {
    on<RoomAddEvent>(_addRoom);
    on<RoomLoadedEvent>(_loadedRoom);
    on<RoomDeleteEvent>(_deleteRoom);
  }
  _addRoom(RoomAddEvent event, emit) async {
    try {
      final shared = await SharedPreferences.getInstance();
      final token = shared.getString('token');

      if (token == null) {
        emit(RoomError(message: 'Token dont have'));
        return;
      }
      // ignore: unused_local_variable
      final roomInfo = await roomService.addRoom(
          token, event.name, event.desc, event.capacity);
    } catch (e) {
      emit(RoomError(message: e.toString()));
    }
  }

  _loadedRoom(RoomLoadedEvent event, emit) async {
    try {
      final shared = await SharedPreferences.getInstance();
      final token = shared.getString('token');

      if (token == null) {
        emit(RoomError(message: 'Token dont have'));
        return;
      }
      final responce = await roomService.getRooms(token);
      emit(
        RoomLoaded(groups: responce),
      );
    } catch (e) {
      emit(RoomError(message: e.toString()));
    }
  }

  _deleteRoom(RoomDeleteEvent event, emit) async {
    try {
      final shared = await SharedPreferences.getInstance();
      final token = shared.getString('token');
      final groups = (state as RoomLoaded).groups;

      if (token == null) {
        emit(RoomError(message: 'Token not found'));
        return;
      }
      final List<dynamic> updatedRooms =
          groups['data'].where((room) => room['id'] != event.id).toList();

      final Map<String, dynamic> newGroups = {
        ...groups,
        'data': updatedRooms,
      };
      await roomService.deleteRooms(token, event.id);

      emit(RoomLoaded(groups: newGroups));
    } catch (e) {
      emit(RoomError(message: e.toString()));
    }
  }
}
