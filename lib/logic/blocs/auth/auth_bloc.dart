import 'package:bloc/bloc.dart';
import 'package:crmo/data/models/register_request.dart';
import 'package:crmo/logic/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService = AuthService();

  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>(_login);
    on<RegisterEvent>(_register);
    on<LogoutEvent>(_logout);
    on<CheckUserEvent>(_checkUser);
  }

  Future<void> _login(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // ignore: unused_local_variable
      Map<String, dynamic> responce =
          await authService.signIn(event.email, event.password);

      emit(AuthenticatedState());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _register(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authService.signUp(event.request);
      emit(AuthenticatedState());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _logout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final shared = await SharedPreferences.getInstance();
      final accessToken = shared.getString('token');

      if (accessToken == null) {
        emit(AuthError('No access token found. Unable to logout.'));
        return;
      }
      await authService.signOut(accessToken);
      await shared.clear();
      emit(UnauthenticatedState());
    } catch (e) {
      emit(AuthError('Logout failed: $e'));
    }
  }

  Future<void> _checkUser(event, emit) async {
    emit(AuthLoading());
    try {
      final shared = await SharedPreferences.getInstance();
      final token = shared.getString('token');
      if (token != null) {
        emit(AuthenticatedState());
      } else {
        emit(UnauthenticatedState());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
