import 'package:crmo/logic/blocs/room/room_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddRoomScreen extends StatefulWidget {
  const AddRoomScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddRoomScreenState createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends State<AddRoomScreen> {
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  double sliderValue = 20;
  final _formKey = GlobalKey<FormState>();
  submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.read<RoomBloc>().add(
            RoomAddEvent(
              name: groupNameController.text,
              desc: descController.text,
              capacity: sliderValue.toInt(),
            ),
          );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ADD GROUP"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: groupNameController,
                decoration: InputDecoration(
                  labelText: 'Room Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
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
              TextFormField(
                controller: descController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a descirption ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Text(
                'Select Number of Students: ${sliderValue.toInt()}',
              ),
              Slider(
                value: sliderValue,
                min: 0,
                max: 40,
                divisions: 40,
                label: sliderValue.toInt().toString(),
                onChanged: (double value) {
                  setState(
                    () {
                      sliderValue = value;
                    },
                  );
                },
              ),
              
              Center(
                child: ElevatedButton(
                  onPressed: () => submit(),
                  child: const Text("ADD"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
