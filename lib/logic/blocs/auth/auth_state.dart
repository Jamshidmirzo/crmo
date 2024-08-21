part of 'auth_bloc.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthenticatedState extends AuthState {}

final class UnauthenticatedState extends AuthState {}

final class AuthLoading extends AuthState {}

final class GetUserState extends AuthState {}

final class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
