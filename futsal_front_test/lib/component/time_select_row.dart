import 'package:flutter/material.dart';
import 'package:futsal_front_test/component/apply_button.dart';
import 'package:futsal_front_test/component/time_container.dart';

class TimeSelectRow extends StatefulWidget {
  const TimeSelectRow({super.key});

  @override
  State<TimeSelectRow> createState() => _TimeSelectRowState();
}

class _TimeSelectRowState extends State<TimeSelectRow> {
  String _hour = DateTime.now().hour.toString().padLeft(2, "0");
  String _minute = DateTime.now().minute.toString().padLeft(2, "0");
  String _amOrPm = "AM";
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Future<TimeOfDay?> selectedTime = showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        selectedTime.then((timeOfDay) {
          setState(() {
            _hour = timeOfDay!.hour.toString().padLeft(2, "0");
            _minute = timeOfDay.minute.toString().padLeft(2, "0");

            if (timeOfDay.hour >= 12) {
              _amOrPm = "PM";
            } else {
              {
                _amOrPm = "AM";
              }
            }
          });
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              TimeContainer(
                content: _hour,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                child: Text(":"),
              ),
              TimeContainer(
                content: _minute,
              ),
              const SizedBox(
                width: 10,
              ),
              TimeContainer(
                content: _amOrPm,
              ),
            ],
          ),
          ApplyButton(
            onPressed: () {
              print("left_part!");
            },
          ),
        ],
      ),
    );
  }
}
