import 'dart:async';

import 'package:flutter/material.dart';

class PomodoroHomeScreen extends StatefulWidget {
  const PomodoroHomeScreen({super.key});

  @override
  State<PomodoroHomeScreen> createState() => _PomodoroHomeScreenState();
}

class _PomodoroHomeScreenState extends State<PomodoroHomeScreen> {
  static const int pomodoro = 10;
  int pomodoroTime = pomodoro;

  bool isRunnig = false;
  late Timer timer;
  int totalPomodoro = 0;

  void onTick(Timer timer) {
    setState(() {
      if (pomodoroTime == 0) {
        totalPomodoro++;
        pomodoroTime = pomodoro;
        onPressStop();
      } else {
        pomodoroTime--;
      }
    });
  }

  void onPressedStart() {
    setState(() {
      isRunnig = true;
      timer = Timer.periodic(const Duration(seconds: 1), onTick);
    });
  }

  void onPressStop() {
    setState(() {
      isRunnig = false;
      timer.cancel();
    });
  }

  void onPressedReset() {
    setState(() {
      onPressStop();
      totalPomodoro = 0;
      pomodoroTime = pomodoro;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[400],
      body: Column(
        children: [
          Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "$pomodoroTime",
                  style: const TextStyle(
                    fontSize: 100,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
          Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    color: Colors.blue,
                    iconSize: 100,
                    onPressed: isRunnig ? onPressStop : onPressedStart,
                    icon: Icon(
                      isRunnig
                          ? Icons.pause_circle_outline
                          : Icons.play_circle_fill_outlined,
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  IconButton(
                    color: Colors.blue,
                    iconSize: 100,
                    onPressed: onPressedReset,
                    icon: const Icon(
                      Icons.restore_rounded,
                    ),
                  )
                ],
              )),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.deepOrangeAccent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Pomodoros:",
                    style: TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Text(
                    "$totalPomodoro",
                    style: const TextStyle(
                      fontSize: 100,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
