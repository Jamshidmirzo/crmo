import 'package:bloc/bloc.dart';
import 'package:crmo/data/models/register_request.dart';
import 'package:crmo/logic/services/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService = AuthService();
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});
    on<LoginEvent>(_login);
    on<RegisterEvent>(_register);
    on<LogoutEvent>(_logout);
  }

  _login(LoginEvent event, state) {
    return authService.signIn(event.email, event.password);
  }

  _register(RegisterEvent event, state) {
    return authService.signUp(event.request);
  }

  _logout(LogoutEvent event, state) {
    return authService.signOut(event.accessToken);
  }
}
