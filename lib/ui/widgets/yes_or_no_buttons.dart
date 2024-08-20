import 'package:flutter/material.dart';

class YesNoRadioButtons extends StatefulWidget {
  @override
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
            Text('Yes'),
          ],
        ),
        SizedBox(width: 20),
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
            Text('No'),
          ],
        ),
      ],
    );
  }
}
