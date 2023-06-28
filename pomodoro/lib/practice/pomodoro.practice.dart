import 'package:flutter/material.dart';
import 'package:pomodoro/practice/screens/pomodoro.homescreen.dart';

void main() {
  runApp(const MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PomodoroHomeScreen(),
    );
  }
}
