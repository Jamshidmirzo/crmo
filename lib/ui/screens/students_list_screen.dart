import 'package:crmo/ui/screens/groups_tab.dart';
import 'package:crmo/ui/screens/students_tab.dart';
import 'package:crmo/ui/screens/teachers_tab.dart';
import 'package:flutter/material.dart';

class StudentsListScreen extends StatelessWidget {
  const StudentsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Students and Teachers"),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Students',
              ),
              Tab(
                text: 'Teachers',
              ),
              Tab(
                text: 'Groups',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [StudentsTab(), TeachersTab(), GroupsTab()],
        ),
      ),
    );
  }
}
