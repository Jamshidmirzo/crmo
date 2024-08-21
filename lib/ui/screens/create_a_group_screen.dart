import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateAGroupScreen extends StatelessWidget {
  const CreateAGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Create a Group"),
      ),
    );
  }
}
