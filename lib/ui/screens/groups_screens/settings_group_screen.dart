import 'package:crmo/data/models/teacher.dart';
import 'package:crmo/logic/blocs/group/group_bloc.dart';
import 'package:crmo/logic/blocs/user/user_bloc.dart';
import 'package:crmo/logic/blocs/user/user_event.dart';
import 'package:crmo/logic/blocs/user/user_state.dart';
import 'package:crmo/ui/screens/groups_screens/time_table_adding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class SettingsGroupScreen extends StatefulWidget {
  final String name;
  final String teacherName;
  final Map groups;

  const SettingsGroupScreen({
    super.key,
    required this.name,
    required this.teacherName,
    required this.groups,
  });

  @override
  State<SettingsGroupScreen> createState() => _SettingsGroupScreenState();
}

class _SettingsGroupScreenState extends State<SettingsGroupScreen> {
  final nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<Teacher> _teachers = [];
  Teacher? _selectedTeacher;
  bool _isLoading = true;
  List students = [];

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    _fetchTeachers();
  }

  Future<void> _fetchTeachers() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final bloc = BlocProvider.of<UserBloc>(context);
      bloc.add(GetTeacherEvent());

      bloc.stream.listen((state) {
        if (state is UserGetTeacherState) {
          setState(() {
            _teachers = state.info.data;
            _selectedTeacher = _teachers.firstWhere(
              (teacher) => teacher.name == widget.teacherName,
            );
            _isLoading = false;
          });
        } else if (state is UserErrorState) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> submit() async {
    final response = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  {'students': students},
                );
              },
              child: const Text("Done"),
            ),
          ],
          content: SizedBox(
            height: 300,
            width: double.maxFinite,
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserErrorState) {
                  return Center(
                    child: Text(state.message),
                  );
                }

                if (state is UserGetStudentsState) {
                  if (state.info.data.isEmpty) {
                    return const Center(
                      child: Text("No students found."),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.info.data.length,
                    itemBuilder: (context, index) {
                      final info = state.info.data[index];
                      return ZoomTapAnimation(
                        onTap: () {
                          students.add(info.id);
                        },
                        child: ListTile(
                          title: Text(info.name),
                          subtitle: Text(info.phone),
                        ),
                      );
                    },
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        );
      },
    );
    if (response != null) {
      // ignore: use_build_context_synchronously
      context.read<GroupBloc>().add(GroupAddedStudnetsEvent(
            students: students,
            groupId: widget.groups['id'],
          ));
    }
  }

  void edit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_selectedTeacher != null) {
        context.read<GroupBloc>().add(
              GroupAddEvent(
                assitant_teacher_id: 4,
                name: nameController.text,
                teacherId: _selectedTeacher!.id,
              ),
            );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<GroupBloc, GroupState>(
        listener: (context, state) {
          if (state is GroupsLoaded) {
            setState(() {
              // Don't reset the teachers list or selected teacher unless necessary
              if (_teachers.isEmpty) {
                _teachers =
                    state.groups['teachers']?.map<Teacher>((teacherJson) {
                          return Teacher.fromJson(teacherJson);
                        }).toList() ??
                        [];
                _selectedTeacher = _teachers.firstWhere(
                  (teacher) => teacher.name == widget.teacherName,
                );
              }
              _isLoading = false;
            });
          } else if (state is GroupError) {
            setState(() {
              _isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Name of group',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a group name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                if (_isLoading)
                  const Center(child: CircularProgressIndicator())
                else
                  DropdownButtonFormField<Teacher>(
                    value: _selectedTeacher,
                    hint: const Text('Select Teacher'),
                    items: _teachers.map((teacher) {
                      return DropdownMenuItem<Teacher>(
                        value: teacher,
                        child: Text(teacher.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedTeacher = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return TimeTableAddingScreen(id: widget.groups['id']);
                        },
                      ),
                    );
                  },
                  child: const Text("Add Time Table"),
                ),
                ElevatedButton(
                  onPressed: submit,
                  child: const Text("ADD STUDENT"),
                ),
                ElevatedButton(
                  onPressed: edit,
                  child: const Text("EDIT"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
