import 'package:crmo/logic/blocs/user/user_bloc.dart';
import 'package:crmo/logic/blocs/user/user_event.dart';
import 'package:crmo/logic/blocs/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminsTab extends StatefulWidget {
  const AdminsTab({super.key});

  @override
  State<AdminsTab> createState() => _AdminsTabState();
}

class _AdminsTabState extends State<AdminsTab> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetAdminsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserGetAdminsState) {
            return ListView.builder(
              itemCount: state.info.data.length,
              itemBuilder: (context, index) {
                final admin = state.info.data[index];
                return ListTile(
                  title: Text(admin.name),
                  subtitle: Text(admin.phone),
                );
              },
            );
          }
          if (state is UserErrorState) {
            return Center(
              child: Text(state.message),
            );
          }
          return Container();
        },
      ),
    );
  }
}
