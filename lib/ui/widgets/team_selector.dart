// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class TeamSizeSelector extends StatefulWidget {
  @override
  _TeamSizeSelectorState createState() => _TeamSizeSelectorState();
}

class _TeamSizeSelectorState extends State<TeamSizeSelector> {
  final List<String> options = [
    "Only me",
    "2 - 5",
    "6 - 10",
    "11 - 20",
    "21 - 40",
    "41 - 50",
    "51 - 100",
    "101 - 500"
  ];

  String selectedOption = "21 - 40"; // Default selected option

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: options.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2.5,
      ),
      padding: const EdgeInsets.all(20),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedOption = options[index];
            });
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color:
                  selectedOption == options[index] ? Colors.blue : Colors.white,
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              options[index],
              style: TextStyle(
                color: selectedOption == options[index]
                    ? Colors.white
                    : Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
