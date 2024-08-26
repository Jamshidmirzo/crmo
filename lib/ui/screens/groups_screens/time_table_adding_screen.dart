import 'package:crmo/logic/blocs/timetable/timetable_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TimeTableAddingScreen extends StatefulWidget {
  final int id;
  const TimeTableAddingScreen({super.key, required this.id});

  @override
  State<TimeTableAddingScreen> createState() => _TimeTableAddingScreenState();
}

class _TimeTableAddingScreenState extends State<TimeTableAddingScreen> {
  double sliderValue = 5;
  double sliderValueDay = 1;

  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

  Future<void> _selectTime(
      BuildContext context, TextEditingController controller) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      final now = DateTime.now();
      final selectedTime = DateTime(
          now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);
      final formattedTime = DateFormat('HH:mm').format(selectedTime);
      setState(() {
        controller.text = formattedTime;
      });
    }
  }

  submit() {
    context.read<TimetableBloc>().add(
          TimetableAddEvent(
              group_id: widget.id,
              room_id: sliderValue.toInt(),
              day_id: sliderValueDay.toInt(),
              start_time: startTimeController.text,
              end_time: endTimeController.text),
        );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ROOM SETTINGS"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'GROUP ID:${widget.id}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: startTimeController,
                    decoration: InputDecoration(
                      hintText: 'Start Time',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    readOnly: true,
                    onTap: () => _selectTime(context, startTimeController),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: endTimeController,
                    decoration: InputDecoration(
                      hintText: 'End Time',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    readOnly: true,
                    onTap: () => _selectTime(context, endTimeController),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('ROOM ID'),
            Slider(
              value: sliderValue,
              min: 0,
              max: 10,
              divisions: 40,
              label: sliderValue.toInt().toString(),
              onChanged: (double value) {
                setState(
                  () {
                    sliderValue = value;
                  },
                );
              },
            ),
            const Text('DAY ID'),
            Slider(
              value: sliderValueDay,
              min: 0,
              max: 7,
              divisions: 40,
              label: sliderValueDay.toInt().toString(),
              onChanged: (double value) {
                setState(
                  () {
                    sliderValueDay = value;
                  },
                );
              },
            ),
            Center(
              child: ElevatedButton(
                onPressed: () => submit(),
                child: const Text("SAVE"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
