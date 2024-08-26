import 'package:crmo/logic/blocs/user/user_bloc.dart';
import 'package:crmo/logic/blocs/user/user_event.dart';
import 'package:crmo/logic/blocs/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeachersTab extends StatefulWidget {
  const TeachersTab({super.key});

  @override
  State<TeachersTab> createState() => _TeachersTabState();
}

class _TeachersTabState extends State<TeachersTab> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetTeacherEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserErrorState) {
          return Center(
            child: Text(state.message),
          );
        }

        if (state is UserGetTeacherState) {
          return ListView.builder(
            itemCount: state.info.data.length, 
            itemBuilder: (context, index) {
              final info = state.info.data[index];
              return ListTile(
                title: Text(info.name),
                subtitle: Text(info.phone),
              );
            },
          );
        }

       
        return const Center(
          child:
              CircularProgressIndicator(), 
        );
      },
    );
  
  }
}
