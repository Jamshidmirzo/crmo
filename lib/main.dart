import 'package:crmo/logic/blocs/auth/auth_bloc.dart';
import 'package:crmo/logic/blocs/group/group_bloc.dart';
import 'package:crmo/logic/blocs/room/room_bloc.dart';
import 'package:crmo/logic/blocs/subject/subject_bloc.dart';
import 'package:crmo/logic/blocs/timetable/timetable_bloc.dart';
import 'package:crmo/logic/blocs/user/user_bloc.dart';
import 'package:crmo/logic/services/user_service.dart';
import 'package:crmo/ui/screens/bottom_navigation_bar/bottom_nav_bar.dart';
import 'package:crmo/ui/screens/auth_screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => UserBloc(userService: UserService()),
        ),
        BlocProvider(
          create: (context) => GroupBloc(),
        ),
        BlocProvider(
          create: (context) => RoomBloc(),
        ),
        BlocProvider(
          create: (context) => TimetableBloc(),
        ),
        BlocProvider(
          create: (context) => SubjectBloc(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(CheckUserEvent());

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthenticatedState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const BottomNavBar()),
          );
        } else if (state is UnauthenticatedState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SignInScreen()),
          );
        }
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
