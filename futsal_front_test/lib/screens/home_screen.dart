import 'package:flutter/material.dart';
import 'package:futsal_front_test/screens/home_left_part_screen.dart';
import 'package:futsal_front_test/screens/home_right_part_screen.dart';
import 'package:futsal_front_test/component/my_container.dart';

/*
Container 사이즈 정하기 보류,,,
상태 관리 어떻게 하지..

home right part에서 Column안에 각 위젯들 padding을 한 번에 처리 못하나?

*/
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: MyContainer(
            height: height,
            width: width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HomeLeftPart(
                  height: height,
                  width: width,
                ),
                const SizedBox(
                  width: 20,
                ),
                HomeRightPart(
                  height: height,
                  width: width,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
