import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:crmo/logic/blocs/user/user_event.dart';
import 'package:crmo/logic/blocs/user/user_state.dart';
import 'package:crmo/logic/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService userService;

  UserBloc({required this.userService}) : super(UserInitial()) {
    on<GetUserEvent>(_getUser);
    on<UpdateInfoUserEvent>(_updateUserInfo);
  }

  Future<void> _getUser(GetUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    try {
      final shared = await SharedPreferences.getInstance();
      final token = shared.getString('token');
      print(token);

      if (token == null) {
        emit(UserErrorState(message: 'Token is missing.'));
        return;
      }

      final userInfo = await userService.getUser(token);
      emit(UserGetState(info: userInfo));
    } catch (e) {
      emit(UserErrorState(message: 'Failed to load user: $e'));
    }
  }

  Future<void> _updateUserInfo(UpdateInfoUserEvent event, emit) async {
    final shared = await SharedPreferences.getInstance();
    final token = shared.getString('token');

    userService.updateProfile(
      phone: event.phone,
      accessToken: token!,
      name: event.name,
      photo: event.photo,
    );
  }
}
