// ignore_for_file: use_build_context_synchronously

import 'package:crmo/logic/blocs/auth/auth_bloc.dart';
import 'package:crmo/ui/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Screen'),
          actions: [
            IconButton(
              onPressed: () async {
                final shared = await SharedPreferences.getInstance();
                final accessToken = shared.getString('token');
                if (accessToken != null) {
                  context.read<AuthBloc>().add(
                        LogoutEvent(accessToken: accessToken),
                      );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Token not found.')),
                  );
                }
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return const Center(child: CircularProgressIndicator());
                },
              );
            } else if (state is UnauthenticatedState) {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignInScreen(),
                ),
              );
            } else if (state is AuthError) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: const Center(
            child: Text('Welcome to the Home Screen!'),
          ),
        ));
  }
}
