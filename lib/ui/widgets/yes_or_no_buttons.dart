import 'package:flutter/material.dart';

class YesNoRadioButtons extends StatefulWidget {
  const YesNoRadioButtons({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _YesNoRadioButtonsState createState() => _YesNoRadioButtonsState();
}

class _YesNoRadioButtonsState extends State<YesNoRadioButtons> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            Radio<String>(
              value: 'Yes',
              groupValue: selectedOption,
              onChanged: (value) {
                setState(() {
                  selectedOption = value;
                });
              },
            ),
            const Text('Yes'),
          ],
        ),
        const SizedBox(width: 20),
        Row(
          children: [
            Radio<String>(
              value: 'No',
              groupValue: selectedOption,
              onChanged: (value) {
                setState(() {
                  selectedOption = value;
                });
              },
            ),
            const Text('No'),
          ],
        ),
      ],
    );
  }
}
