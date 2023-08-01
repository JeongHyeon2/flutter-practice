import 'package:flutter/material.dart';
import 'package:futsal_front_test/component/allow_booking_for_user_row.dart';
import 'package:futsal_front_test/component/booking_setting_status_row.dart';
import 'package:futsal_front_test/component/my_container.dart';
import 'package:futsal_front_test/component/talbe_calendar.dart';
import 'package:futsal_front_test/component/time_select_row.dart';

class HomeLeftPart extends StatefulWidget {
  final double height;
  final double width;
  const HomeLeftPart({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  State<HomeLeftPart> createState() => _HomeLeftPartState();
}

class _HomeLeftPartState extends State<HomeLeftPart> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: MyContainer(
            title: "예약 시간 설정",
            height: 8.5 / 13 * widget.height,
            width: 4.5 / 10 * widget.width,
            child: const Column(
              children: [
                MyTableCalendar(),
                SizedBox(
                  height: 10,
                ),
                AllowBookingForUserRow(),
                SizedBox(
                  height: 10,
                ),
                TimeSelectRow(),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        MyContainer(
          title: "예약 시간 설정 현황",
          height: 3.5 / 13.0 * widget.height,
          width: 4.5 / 10 * widget.width,
          child: Expanded(
            child: ListView.separated(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return BookingSettingStatusRow(
                    isAllow: index % 2 == 0 ? true : false,
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 7),
                itemCount: 8),
          ),
        ),
      ],
    );
  }
}
