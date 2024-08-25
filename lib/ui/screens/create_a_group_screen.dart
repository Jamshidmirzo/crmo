import 'package:crmo/ui/widgets/adding_group.dart';
import 'package:flutter/material.dart';

class CreateAGroupScreen extends StatelessWidget {
  const CreateAGroupScreen({super.key});
  addGroup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const AddingGroup();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => addGroup(context),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Create a Group"),
      ),
    );
  }
}
