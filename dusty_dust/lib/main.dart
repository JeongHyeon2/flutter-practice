import 'dart:ui';

import 'package:dusty_dust/model/stat_model.dart';
import 'package:dusty_dust/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

const testBox = "test";
void main() async {
  await Hive.initFlutter();
  await Hive.openBox(testBox);

  for (ItemCode itemCode in ItemCode.values) {
    await Hive.openBox<StatModel>(itemCode.name);
  }
  runApp(
    MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      theme: ThemeData(
        fontFamily: 'sunflower',
      ),
      home: const HomeScreen(),
    ),
  );
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
