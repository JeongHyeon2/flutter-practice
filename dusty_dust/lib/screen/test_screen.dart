import 'package:dusty_dust/main.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TestScreen"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "TestScreen",
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
            onPressed: () {
              final box = Hive.box(testBox);
              print("keys: ${box.keys.toList()}");
              print("values: ${box.values.toList()}");
            },
            child: const Text("박스 프린트하기!"),
          ),
          ElevatedButton(
            onPressed: () {
              final box = Hive.box(testBox);
              box.add("테스트3");
            },
            child: const Text("데이터 넣기!"),
          ),
          ElevatedButton(
            onPressed: () {
              final box = Hive.box(testBox);
              print(box.get(1));
            },
            child: const Text("특정 값 가져오기!"),
          ),
        ],
      ),
    );
  }
}
