// ignore_for_file: library_private_types_in_public_api

import 'package:crmo/data/models/teacher.dart';
import 'package:crmo/logic/blocs/group/group_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crmo/logic/blocs/user/user_bloc.dart';
import 'package:crmo/logic/blocs/user/user_event.dart';
import 'package:crmo/logic/blocs/user/user_state.dart';

class AddingGroup extends StatefulWidget {
  const AddingGroup({super.key});

  @override
  _AddingGroupState createState() => _AddingGroupState();
}

class _AddingGroupState extends State<AddingGroup> {
  final nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<Teacher> _teachers = [];
  Teacher? _selectedTeacher;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
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

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_selectedTeacher != null) {
        context.read<GroupBloc>().add(
              GroupAddEvent(
                  name: nameController.text,
                  teacherId: _selectedTeacher!.id,
                  assitant_teacher_id: 4),
            );
        Navigator.pop(context);
      } else {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Group'),
      content: Padding(
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
            ],
          ),
        ),
      ),
     
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
