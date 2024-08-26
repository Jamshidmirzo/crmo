import 'package:crmo/logic/blocs/subject/subject_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddingSubject extends StatelessWidget {
   AddingSubject({super.key});
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.read<SubjectBloc>().add(
            SubjectAddEvent(name: nameController.text),
          );
      context.read<SubjectBloc>().add(SubjectGetEvent());
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("CANCEL"),
        ),
        ElevatedButton(
          onPressed: () => submit(context),
          child: const Text("DONE"),
        ),
      ],
      content: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Input your subject';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Input name of Subject',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
