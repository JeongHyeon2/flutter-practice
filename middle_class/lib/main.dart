import 'package:flutter/material.dart';
import 'package:middle_class/user/login_screen.dart';
import 'package:middle_class/view/splash_screen.dart';

void main() {
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "NotoSans"),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
