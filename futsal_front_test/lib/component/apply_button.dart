import 'package:flutter/material.dart';

class ApplyButton extends StatelessWidget {
  final VoidCallback onPressed;
  const ApplyButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black, // 버튼 텍스트 색상을 흰색으로 설정
        textStyle: const TextStyle(fontSize: 15), // 버튼 텍스트 스타일
        padding: const EdgeInsets.symmetric(
            horizontal: 10, vertical: 10), // 버튼 내부 여백
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ), // 버튼 모서리 둥글기 (선택 사항)
      ),
      child: const Center(
        child: Text(
          "Apply",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
