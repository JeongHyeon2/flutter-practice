import 'package:flutter/material.dart';

class AllowBookingForUserRow extends StatefulWidget {
  const AllowBookingForUserRow({super.key});

  @override
  State<AllowBookingForUserRow> createState() => _AllowBookingForUserRowState();
}

class _AllowBookingForUserRowState extends State<AllowBookingForUserRow> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "일반 사용자 예약 허용",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        SizedBox(
          child: Transform.scale(
            scale: 1.3,
            child: Checkbox(
              value: isChecked,
              onChanged: (value) {
                setState(() {
                  isChecked = value!;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
