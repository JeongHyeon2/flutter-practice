import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'screens/home_screen_webtoon.dart';

void main() {
  runApp(const MyWidget());
}

class MyWidget extends StatelessWidget {
  // 이 위젯의 식별자인 key를 상위 위젯에 전달
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //스크롤을 위함
      scrollBehavior: MyCustomScrollBehavior(),
      home: Scaffold(
        body: HomeScreenWebtoon(),
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
