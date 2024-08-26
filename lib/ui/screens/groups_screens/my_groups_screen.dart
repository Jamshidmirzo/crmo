import 'package:crmo/logic/blocs/user/user_bloc.dart';
import 'package:crmo/logic/blocs/user/user_event.dart';
import 'package:crmo/logic/blocs/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class MyGroupsScreen extends StatefulWidget {
  const MyGroupsScreen({super.key});

  @override
  State<MyGroupsScreen> createState() => _MyGroupsScreenState();
}

class _MyGroupsScreenState extends State<MyGroupsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetGroupsEvent());
  }

  void myGroupdoshlar(List students) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Group Students'),
          content: SizedBox(
            height: 300, 
            width: double.maxFinite, 
            child: students.isEmpty
                ? const Center(child: Text('No students in this group.'))
                : ListView.builder(
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(students[index]['name']),
                      );
                    },
                  ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Groups'),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserErrorState) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state is UserLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UserGetGroupsState) {
            if (state.info['data'].isEmpty) {
              return const Center(child: Text('No groups available.'));
            }
            return ListView.builder(
              itemCount: state.info['data'].length,
              itemBuilder: (context, index) {
                final group = state.info['data'][index];
                final students = group['students'] ?? [];
                return ZoomTapAnimation(
                  onTap: () {
                    myGroupdoshlar(students);
                  },
                  child: ListTile(
                    title: Text(group['name']),
                    subtitle: Text('TEACHER: ${group['main_teacher']['name']}'),
                  ),
                );
              },
            );
          }
          return const Center(child: Text('Something went wrong.'));
        },
      ),
    );
  }
}
