import 'package:dusty_dust/model/stat_model.dart';
import 'package:dusty_dust/model/status_model.dart';
import 'package:dusty_dust/utils/data_utility.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget {
  final String region;
  final StatusModel status;
  final StatModel stat;
  final DateTime dateTime;
  final bool isExpanded;

  const MainAppBar({
    super.key,
    required this.stat,
    required this.dateTime,
    required this.status,
    required this.region,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    const ts = TextStyle(
      color: Colors.white,
      fontSize: 30,
      fontFamily: "sunflower",
    );
    return SliverAppBar(
      expandedHeight: 500,
      pinned: true,
      title: isExpanded
          ? null
          : Text(
              "$region ${DataUtility.getTimeFromDateTime(dateTime: dateTime)}",
            ),
      centerTitle: true,
      backgroundColor: status.primaryColor,
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(
              top: kToolbarHeight,
            ),
            child: Column(
              children: [
                Text(
                  region,
                  style: ts.copyWith(fontWeight: FontWeight.w700),
                ),
                Text(
                  DataUtility.getTimeFromDateTime(dateTime: stat.dataTime),
                  style: ts.copyWith(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Image.asset(
                  status.imagePath,
                  width: MediaQuery.of(context).size.width / 2,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  status.label,
                  style: ts.copyWith(fontSize: 40, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  status.comment,
                  style: ts.copyWith(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
