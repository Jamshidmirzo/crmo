import 'package:crmo/ui/screens/drawers_screens/create_a_group_screen.dart';
import 'package:crmo/ui/screens/groups_screens/edit_groups.dart';
import 'package:crmo/ui/screens/groups_screens/my_groups_screen.dart';
import 'package:crmo/ui/screens/rooms_screen/rooms_screen.dart';
import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            ZoomTapAnimation(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const CreateAGroupScreen();
                    },
                  ),
                );
              },
              child: const ListTile(
                title: Text(
                  "Create a group",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
            ZoomTapAnimation(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const EditGroups();
                    },
                  ),
                );
              },
              child: const ListTile(
                title: Text(
                  "Edit a groups",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
            ZoomTapAnimation(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const MyGroupsScreen();
                    },
                  ),
                );
              },
              child: const ListTile(
                title: Text(
                  "View my groups",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
            ZoomTapAnimation(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const RoomsScreen();
                    },
                  ),
                );
              },
              child: const ListTile(
                title: Text(
                  "View my rooms",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
