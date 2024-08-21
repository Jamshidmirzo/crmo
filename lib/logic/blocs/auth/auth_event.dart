part of 'auth_bloc.dart';

sealed class AuthEvent {}

class RegisterEvent extends AuthEvent {
  final RegisterRequest request;
  RegisterEvent({required this.request});
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  LoginEvent({required this.email, required this.password});
}

class LogoutEvent extends AuthEvent {}


class CheckUserEvent extends AuthEvent {}
