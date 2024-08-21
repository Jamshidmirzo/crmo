import 'package:flutter/material.dart';

class StudentsListScreen extends StatelessWidget {
  const StudentsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, 
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Students and Teachers"),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Students'),
              Tab(text: 'Teachers'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            StudentsTab(),
            TeachersTab(),
          ],
        ),
      ),
    );
  }
}

class StudentsTab extends StatelessWidget {
  const StudentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('List of Students'),
    );
  }
}

class TeachersTab extends StatelessWidget {
  const TeachersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('List of Teachers'),
    );
  }
}
