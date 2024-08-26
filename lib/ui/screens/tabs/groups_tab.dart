import 'package:crmo/logic/blocs/group/group_bloc.dart';
import 'package:crmo/ui/widgets/groups_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsTab extends StatefulWidget {
  const GroupsTab({super.key});

  @override
  State<GroupsTab> createState() => _GroupsTabState();
}

class _GroupsTabState extends State<GroupsTab> {
  @override
  void initState() {
    super.initState();
    context.read<GroupBloc>().add(GroupGetEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GroupBloc, GroupState>(
        builder: (context, state) {
          if (state is GroupError) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state is GroupsLoaded) {
            return ListView.builder(
              itemCount: state.groups['data'].length,
              itemBuilder: (context, index) {
                final groups = state.groups['data'][index];
                return GroupsWidget(
                  groups: groups,
                  id: 1,
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
