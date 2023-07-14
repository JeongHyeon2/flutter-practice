import 'dart:ui';

import 'package:calendar_scheduler/component/schedule_bottom_sheet.dart';
import 'package:calendar_scheduler/component/schedule_card.dart';
import 'package:calendar_scheduler/component/today_banner.dart';
import 'package:calendar_scheduler/const/colors.dart';
import 'package:calendar_scheduler/model/schedule_with_color.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../component/calendar.dart';
import '../database/drift_database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: renderFloatingActionButton(),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Calendar(
                onDaySelected: onDaySelected,
                selectedDay: selectedDay,
                focusedDay: focusedDay,
              ),
              const SizedBox(
                height: 8,
              ),
              TodayBanner(selectedDay: selectedDay),
              const SizedBox(
                height: 8,
              ),
              _ScheduleList(
                selectedDate: selectedDay,
              ),
            ],
          ),
        ),
      ),
    );
  }

  FloatingActionButton renderFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return ScheduleBottomSheet(
              selectedDate: selectedDay,
            );
          },
        );
      },
      backgroundColor: PRIMARY_COLOR,
      child: const Icon(
        Icons.add,
      ),
    );
  }

  onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      this.selectedDay = selectedDay;
      this.focusedDay = selectedDay;
    });
  }
}

class _ScheduleList extends StatelessWidget {
  final DateTime selectedDate;
  const _ScheduleList({
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: StreamBuilder<List<ScheduleWithColor>>(
          stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData && snapshot.data!.isEmpty) {
              return const Center(
                child: Text("스케줄이 없습니다"),
              );
            }

            return ListView.separated(
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 8,
                );
              },
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final scheduleWithColor = snapshot.data![index];
                return Dismissible(
                  key: ObjectKey(scheduleWithColor.schedule.id),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    GetIt.I<LocalDatabase>()
                        .removeSchedule(scheduleWithColor.schedule.id);
                  },
                  child: ScheduleCard(
                    color: Color(
                      int.parse(
                        "FF${scheduleWithColor.categoryColor.hexCode}",
                        radix: 16,
                      ),
                    ),
                    content: scheduleWithColor.schedule.content,
                    endTime: scheduleWithColor.schedule.endTime,
                    startTime: scheduleWithColor.schedule.startTime,
                  ),
                );
              },
            );
          },
        ),
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
