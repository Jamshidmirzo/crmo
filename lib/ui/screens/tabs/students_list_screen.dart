import 'package:crmo/ui/screens/tabs/admins_tab.dart';
import 'package:crmo/ui/screens/tabs/groups_tab.dart';
import 'package:crmo/ui/screens/tabs/students_tab.dart';
import 'package:crmo/ui/screens/tabs/teachers_tab.dart';
import 'package:flutter/material.dart';

class StudentsListScreen extends StatelessWidget {
  const StudentsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
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
                text: 'Admins',
              ),
              Tab(
                text: 'Groups',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [StudentsTab(), TeachersTab(), AdminsTab(), GroupsTab()],
        ),
      ),
    );
  }
}
