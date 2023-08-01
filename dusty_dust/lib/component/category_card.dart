import 'package:dusty_dust/component/card_title.dart';
import 'package:dusty_dust/component/main_card.dart';
import 'package:dusty_dust/model/stat_and_status_model.dart';
import 'package:dusty_dust/utils/data_utility.dart';
import 'package:flutter/material.dart';

import 'main_stat.dart';

class CategoryCard extends StatelessWidget {
  final Color darkColor;
  final Color lightColor;
  final String region;
  final List<StatAndStatusModel> models;
  const CategoryCard({
    required this.darkColor,
    required this.lightColor,
    super.key,
    required this.models,
    required this.region,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: MainCard(
        backgroundColor: lightColor,
        child: LayoutBuilder(builder: (context, constraint) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CardTitle(
                title: "종류별 통계",
                backgroundColor: darkColor,
              ),
              Expanded(
                child: ListView(
                  physics: const PageScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: models
                      .map(
                        (model) => MainStat(
                          categoty: DataUtility.getItemCodeKrString(
                              itemCode: model.itemCode),
                          imgPath: model.status.imagePath,
                          level: model.status.label,
                          stat: "${model.stat.getLevelFromRegion(
                            region,
                          )}${DataUtility.getUnitFromItemCode(
                            itemCode: model.itemCode,
                          )}",
                          width: constraint.maxWidth / 3,
                        ),
                      )
                      .toList(),
                  //   children: List.generate(
                  //     20,
                  //     (index) => MainStat(
                  //       categoty: "미세먼지",
                  //       imgPath: "asset/img/best.png",
                  //       level: "최고",
                  //       stat: "0㎍/㎥",
                  //       width: constraint.maxWidth / 3,
                  //     ),
                  //   ),
                  // ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
