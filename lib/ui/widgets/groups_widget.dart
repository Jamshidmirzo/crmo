import 'package:crmo/logic/blocs/user/user_bloc.dart';
import 'package:crmo/logic/blocs/user/user_event.dart';
import 'package:crmo/ui/screens/groups_screens/settings_group_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class GroupsWidget extends StatefulWidget {
  final Map<String, dynamic> groups;
  final int id;
  const GroupsWidget({
    super.key,
    required this.groups,
    required this.id,
  });

  @override
  State<GroupsWidget> createState() => _GroupsWidgetState();
}

class _GroupsWidgetState extends State<GroupsWidget> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetStundetsEvent());
  }

  void submit(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return SettingsGroupScreen(
            groups: widget.groups,
            name: widget.groups['name'],
            teacherName: widget.groups['main_teacher']['name'],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: widget.id == 1
          ? null
          : () {
              submit(context);
            },
      child: ListTile(
        title: Text(
          widget.groups['name'],
        ),
        subtitle: Text(
          '${widget.groups['students'].length} STUDENTS',
        ),
      ),
    );
  }
}
