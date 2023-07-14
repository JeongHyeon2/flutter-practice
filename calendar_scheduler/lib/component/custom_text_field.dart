import 'package:calendar_scheduler/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String lable;
  final bool isTime;
  final FormFieldSetter<String> onSaved;
  const CustomTextField({
    super.key,
    required this.lable,
    required this.isTime,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          lable,
          style: const TextStyle(
            color: PRIMARY_COLOR,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (isTime) renderTextField(),
        if (!isTime)
          Expanded(
            child: renderTextField(),
          ),
      ],
    );
  }

  Widget renderTextField() {
    return TextFormField(
      onSaved: onSaved,
      validator: (value) {
        if (value == null || value.isEmpty) return "값을 입력해주세요";
        if (isTime) {
          int time = int.parse(value);
          if (time < 0) {
            return "0 이상의 수를 입력해주세요";
          }

          if (time > 24) {
            return "24 이하의 수를 입력해주세요";
          }
        } else {
          if (value.length > 500) {
            return "500자 이하의 글을 입력해주세요";
          }
        }
        return null;
      },
      expands: !isTime,
      maxLines: isTime ? 1 : null,
      cursorColor: Colors.grey,
      keyboardType: isTime ? TextInputType.number : TextInputType.multiline,
      inputFormatters: isTime
          ? [
              FilteringTextInputFormatter.digitsOnly,
            ]
          : [],
      decoration: InputDecoration(
        suffixText: isTime ? "시" : null,
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.grey[300],
      ),
    );
  }
}
