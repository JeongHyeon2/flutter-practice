import 'package:dusty_dust/model/stat_model.dart';
import 'package:dusty_dust/utils/data_utility.dart';
import 'package:flutter/material.dart';

import 'card_title.dart';
import 'main_card.dart';

class HourlyCard extends StatelessWidget {
  final Color darkColor;
  final Color lightColor;
  final String category;
  final List<StatModel> stats;
  final String region;
  const HourlyCard({
    super.key,
    required this.darkColor,
    required this.lightColor,
    required this.category,
    required this.stats,
    required this.region,
  });

  @override
  Widget build(BuildContext context) {
    return MainCard(
      backgroundColor: lightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CardTitle(
            title: "시간별 $category",
            backgroundColor: darkColor,
          ),
          Column(
            children: stats
                .map(
                  (e) => lenderRow(stat: e),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget lenderRow({required StatModel stat}) {
    final status = DataUtility.getStatusFromItemCodeAndValue(
      value: stat.getLevelFromRegion(region),
      itemCode: stat.itemCode,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text("${stat.dataTime.hour}시"),
          ),
          Expanded(
            child: Image.asset(
              status.imagePath,
              height: 20,
            ),
          ),
          Expanded(
            child: Text(
              status.label,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
