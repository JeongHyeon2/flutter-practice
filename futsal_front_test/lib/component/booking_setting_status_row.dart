import 'package:flutter/material.dart';

class BookingSettingStatusRow extends StatelessWidget {
  final bool isAllow;
  const BookingSettingStatusRow({
    super.key,
    required this.isAllow,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            const Text(
              "2023년 05월 25일 20:00:00",
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            RichText(
              text: TextSpan(
                text: "일반 사용자 예약 ",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: isAllow ? "허용됨" : "비허용",
                    style: TextStyle(
                      color: isAllow ? Colors.blue : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          width: 110,
          height: 35,
          color: Colors.grey,
          child: const Center(
            child: Text(
              "진행 대기",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const Icon(
          Icons.close_rounded,
          color: Colors.red,
          weight: 100,
          size: 25,
        ),
      ],
    );
  }
}
