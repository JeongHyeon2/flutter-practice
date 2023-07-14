import 'dart:math';

import 'package:flutter/material.dart';

const Color PRIMARY_COLOR = Color(0xFF2D2D33);
const Color RED_COLOR = Color(0xFFEA4955);
const Color BLUE_COLOR = Color(0xFF549FBF);

void main() {
  runApp(
    const MaterialApp(
      home: HomeScreen(),
    ),
  );
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int maxNumber = 1000;
  List<int> randomNumbers = [
    123,
    456,
    789,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(onPressed: onSettingsPop),
              _Body(randomNumbers: randomNumbers),
              _Footer(onPressed: onRandomNumberGenerate),
            ],
          ),
        ),
      ),
    );
  }

  void onRandomNumberGenerate() {
    final rnd = Random();
    final Set<int> numbers = {};
    while (numbers.length != 3) {
      final num = rnd.nextInt(maxNumber);
      numbers.add(num);
    }

    setState(() {
      randomNumbers = numbers.toList();
    });
  }

  void onSettingsPop() async {
    final result = await Navigator.of(context).push<int>(
      MaterialPageRoute(
        builder: (context) {
          return SettingsScreen(
            maxNumber: maxNumber,
          );
        },
      ),
    );
    setState(() {
      maxNumber = result!.toInt();
    });
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.randomNumbers,
  });

  final List<int> randomNumbers;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: randomNumbers
            .asMap()
            .entries
            .map(
              (e) => Padding(
                padding: EdgeInsets.only(
                    bottom: e.key == randomNumbers.asMap().length - 1 ? 0 : 16),
                child: Row(
                  children: e.value
                      .toString()
                      .split("")
                      .map(
                        (x) => Image.asset(
                          "asset/img/$x.png",
                          height: 70,
                          width: 50,
                        ),
                      )
                      .toList(),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onPressed;
  const _Header({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "랜덤 숫자 생성기",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),
        IconButton(
          onPressed: () {
            onPressed();
          },
          icon: const Icon(
            Icons.settings,
            color: RED_COLOR,
          ),
        ),
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  final VoidCallback onPressed;
  const _Footer({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: RED_COLOR),
        onPressed: onPressed,
        child: const Text("생성하기"),
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  final int maxNumber;
  const SettingsScreen({
    super.key,
    required this.maxNumber,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late double maxNum;
  @override
  void initState() {
    maxNum = widget.maxNumber.toDouble();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Row(
                  children: maxNum
                      .toInt()
                      .toString()
                      .split("")
                      .map(
                        (e) => Image.asset(
                          "asset/img/$e.png",
                          width: 50,
                          height: 70,
                        ),
                      )
                      .toList(),
                ),
              ),
              Slider(
                value: maxNum,
                min: 1000,
                max: 1000000,
                onChanged: (value) {
                  setState(() {
                    maxNum = value;
                  });
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: RED_COLOR,
                ),
                onPressed: () {
                  Navigator.of(context).pop(maxNum.toInt());
                },
                child: const Text("저장!"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
