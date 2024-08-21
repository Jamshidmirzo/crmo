

sealed class UserState {
  const UserState();
}

final class UserInitial extends UserState {}

final class UserLoadingState extends UserState {}

final class UserGetState extends UserState {
  Map<String, dynamic> info;
  UserGetState({required this.info});
}

final class UserErrorState extends UserState {
  String message;
  UserErrorState({required this.message});
}
