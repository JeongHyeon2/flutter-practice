import 'package:flutter/material.dart';

class MainStat extends StatelessWidget {
  // 미세먼지, 초미세먼지 등
  final String categoty;
  // 아이콘 위치
  final String imgPath;
  // 오염 정도
  final String level;
  // 오염 수치
  final String stat;
  final double width;
  const MainStat({
    super.key,
    required this.categoty,
    required this.imgPath,
    required this.level,
    required this.stat,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    const ts = TextStyle(
      color: Colors.black,
    );
    return SizedBox(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            categoty,
            style: ts,
          ),
          const SizedBox(
            height: 8,
          ),
          Image.asset(
            imgPath,
            width: 50,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            level,
            style: ts,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            stat,
            style: ts,
          ),
        ],
      ),
    );
  }
}
