import 'package:calendar_scheduler/const/colors.dart';
import 'package:calendar_scheduler/database/drift_database.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'custom_text_field.dart';

class ScheduleBottomSheet extends StatefulWidget {
  final DateTime selectedDate;

  const ScheduleBottomSheet({
    super.key,
    required this.selectedDate,
  });

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();

  int? startTime;
  int? endTime;
  String? content;
  int? selectedColorId;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SafeArea(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height / 2 + bottomInset,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: bottomInset,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
                top: 16,
              ),
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Time(
                      onStartSaved: (newValue) {
                        startTime = int.parse(newValue!);
                      },
                      onEndSaved: (newValue) {
                        endTime = int.parse(newValue!);
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    _Content(
                      onSaved: (newValue) {
                        content = newValue;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    FutureBuilder<List<CategoryColor>>(
                      future: GetIt.I<LocalDatabase>().getCategoryColors(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData &&
                            selectedColorId == null &&
                            snapshot.data!.isNotEmpty) {
                          selectedColorId = snapshot.data![0].id;
                        }
                        return _ColorPicker(
                          colors: snapshot.hasData ? snapshot.data! : [],
                          selectedColorId: selectedColorId,
                          colorIdSetter: (id) {
                            setState(() {
                              selectedColorId = id;
                            });
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    _SaveButton(
                      onPressed: onSavePressed,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSavePressed() async {
    if (formKey.currentState == null) {
      return;
    }

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final key = await GetIt.I<LocalDatabase>().createSchedule(
        SchedulesCompanion(
          date: Value(widget.selectedDate),
          startTime: Value(startTime!),
          endTime: Value(endTime!),
          content: Value(content!),
          colorId: Value(selectedColorId!),
        ),
      );
      Navigator.of(context).pop();
    } else {}
  }
}

class _Content extends StatelessWidget {
  final FormFieldSetter<String> onSaved;

  const _Content({
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        onSaved: onSaved,
        lable: "내용",
        isTime: false,
      ),
    );
  }
}

class _Time extends StatelessWidget {
  final FormFieldSetter<String> onStartSaved;
  final FormFieldSetter<String> onEndSaved;

  const _Time({
    required this.onStartSaved,
    required this.onEndSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            onSaved: onStartSaved,
            lable: "시작 시간",
            isTime: true,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: CustomTextField(
            onSaved: onEndSaved,
            lable: "마감 시간",
            isTime: true,
          ),
        ),
      ],
    );
  }
}

typedef ColorIdSetter = Function(int id);

class _ColorPicker extends StatelessWidget {
  final List<CategoryColor> colors;
  final int? selectedColorId;
  final ColorIdSetter colorIdSetter;

  const _ColorPicker({
    required this.colors,
    required this.selectedColorId,
    required this.colorIdSetter,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 10,
      children: colors
          .map(
            (e) => GestureDetector(
              onTap: () {
                colorIdSetter(e.id);
              },
              child: renderColor(
                e,
                selectedColorId == e.id,
              ),
            ),
          )
          .toList(),
    );
  }

  Widget renderColor(CategoryColor color, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(
          int.parse(
            "FF${color.hexCode}",
            radix: 16,
          ),
        ),
        border: isSelected
            ? Border.all(
                color: Colors.black,
                width: 4,
              )
            : null,
      ),
      width: 32,
      height: 32,
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _SaveButton({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: PRIMARY_COLOR,
            ),
            onPressed: () => onPressed(),
            child: const Text("저장"),
          ),
        ),
      ],
    );
  }
}
