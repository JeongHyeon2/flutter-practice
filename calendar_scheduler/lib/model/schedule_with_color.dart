import 'package:calendar_scheduler/database/drift_database.dart';

class ScheduleWithColor {
  final Schedule schedule;
  final CategoryColor categoryColor;

  ScheduleWithColor({
    required this.categoryColor,
    required this.schedule,
  });
}
