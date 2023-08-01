import 'package:flutter/material.dart';

class BookingFuntionSettingRow extends StatefulWidget {
  final String content;
  final bool isCheckBox;

  const BookingFuntionSettingRow({
    super.key,
    required this.content,
    required this.isCheckBox,
  });

  @override
  State<BookingFuntionSettingRow> createState() =>
      _BookingFuntionSettingRowState();
}

class _BookingFuntionSettingRowState extends State<BookingFuntionSettingRow> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.content,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Row(
          children: [
            if (!widget.isCheckBox)
              SizedBox(
                height: 50,
                width: 100,
                child: TextField(
                  onChanged: (text) {
                    setState(() {});
                  },
                  decoration: const InputDecoration(
                    labelText: '', // 입력란 위에 힌트로 보여줄 텍스트
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue, width: 2.0), // 테두리 색상과 두께 설정
                    ), // 입력란의 테두리 스타일
                  ),
                ),
              ),
            if (!widget.isCheckBox)
              const SizedBox(
                width: 10,
              ),
            if (!widget.isCheckBox)
              const Text(
                "회",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        ),
        if (widget.isCheckBox)
          Transform.scale(
            scale: 1.5,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 20,
              ),
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
