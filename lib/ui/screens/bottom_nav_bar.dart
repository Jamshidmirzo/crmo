import 'package:crmo/ui/screens/home_screen.dart';
import 'package:crmo/ui/screens/profile_screen.dart';
import 'package:crmo/ui/screens/students_list_screen.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final List screens = [HomeScreen(), ProfileScreen(), StudentsListScreen()];

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
