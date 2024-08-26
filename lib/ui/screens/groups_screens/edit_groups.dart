import 'package:crmo/logic/blocs/group/group_bloc.dart';
import 'package:crmo/ui/screens/groups_screens/settings_group_screen.dart';
import 'package:crmo/ui/widgets/groups_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class EditGroups extends StatefulWidget {
  const EditGroups({super.key});

  @override
  State<EditGroups> createState() => _EditGroupsState();
}

class _EditGroupsState extends State<EditGroups> {
  String? nameGroup;
  // int? mainTeacherId;
  // int? assistantTeacherId;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    context.read<GroupBloc>().add(GroupGetEvent());
  }

  void _onRefresh() async {
    try {
      context.read<GroupBloc>().add(GroupGetEvent());
      await Future.delayed(const Duration(milliseconds: 1000));
      _refreshController.refreshCompleted();
    } catch (e) {
      _refreshController.refreshFailed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Groups"),
      ),
      body: BlocBuilder<GroupBloc, GroupState>(
        builder: (context, state) {
          if (state is GroupError) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state is GroupsLoaded) {
            return SmartRefresher(
              controller: _refreshController,
              onRefresh: _onRefresh,
              child: ListView.builder(
                itemCount: state.groups['data'].length,
                itemBuilder: (context, index) {
                  final groups = state.groups['data'][index];
                  nameGroup = groups['name'];
                  return GroupsWidget(
                    groups: groups,
                    id: 2,
                  );
                },
              ),
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
