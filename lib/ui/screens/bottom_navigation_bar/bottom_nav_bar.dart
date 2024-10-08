import 'package:crmo/ui/screens/other_screens/home_screen.dart';
import 'package:crmo/ui/screens/profile_screens/profile_screen.dart';
import 'package:crmo/ui/screens/tabs/students_list_screen.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final List screens = [const HomeScreen(), const ProfileScreen(), const StudentsListScreen()];

  int _currentIncdex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          _currentIncdex = value;
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.theater_comedy_sharp), label: ''),
        ],
      ),
      body: screens[_currentIncdex],
    );
  }
}
