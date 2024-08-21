import 'package:crmo/logic/blocs/user/user_bloc.dart';
import 'package:crmo/logic/blocs/user/user_event.dart';
import 'package:crmo/logic/blocs/user/user_state.dart';
import 'package:crmo/ui/screens/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserGetState) {
              return Column(
                children: [
                  Center(
                    child: ZoomTapAnimation(
                      onTap: () {
                        print(state.info['data']['photo']);
                      },
                      child: CircleAvatar(
                        radius: 120,
                        backgroundImage: NetworkImage(
                          state.info['data']['photo'] != null
                              ? 'http://millima.flutterwithakmaljon.uz/storage/avatars/${state.info['data']['photo']}'
                              : 'https://www.wikihow.com/images/thumb/9/90/What_type_of_person_are_you_quiz_pic.png/1200px-What_type_of_person_are_you_quiz_pic.png',
                        ),
                      ),
                    ),
                  ),
                  Text(
                    state.info['data']['name'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 23),
                  ),
                  Text(
                    state.info['data']['role']['name'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 23),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return EditProfileScreen(
                              phone: state.info['data']['phone'],
                              name: state.info['data']['name'],
                            );
                          },
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit Profile'),
                  ),
                ],
              );
            } else if (state is UserErrorState) {
              return Center(child: Text("Error: ${state.message}"));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
