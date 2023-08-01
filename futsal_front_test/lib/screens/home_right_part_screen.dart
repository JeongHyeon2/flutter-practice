import 'package:flutter/material.dart';
import 'package:futsal_front_test/component/apply_button.dart';
import 'package:futsal_front_test/component/booking_funtion_setting_row.dart';
import 'package:futsal_front_test/component/my_container.dart';

class HomeRightPart extends StatefulWidget {
  final double height;
  final double width;
  const HomeRightPart({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  State<HomeRightPart> createState() => _HomeRightPartState();
}

class _HomeRightPartState extends State<HomeRightPart> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: MyContainer(
        title: "예약 기능 설정",
        height: 12 / 13.0 * widget.height + 10,
        width: 4.5 / 10 * widget.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: BookingFuntionSettingRow(
                content: "사용자 별 예약 횟수(평일)",
                isCheckBox: false,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: BookingFuntionSettingRow(
                content: "사용자 별 예약 횟수(주말)",
                isCheckBox: false,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: BookingFuntionSettingRow(
                content: "상시 예약 진행/변경/취소 허용",
                isCheckBox: true,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Text(
                "예약자 페이지 안내문구 설정",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: TextField(
                maxLines: 9,
                onChanged: (text) {
                  setState(() {});
                },
                decoration: const InputDecoration(
                  labelText: '', // 입력란 위에 힌트로 보여줄 텍스트
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ), // 테두리 색상과 두께 설정
                  ), // 입력란의 테두리 스타일
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "변경 후 반드시 적용해야 합니다",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    ApplyButton(
                      onPressed: () {
                        const snackBar = SnackBar(
                          backgroundColor: Colors.grey,
                          duration: Duration(seconds: 3),
                          content: SizedBox(
                            height: 100,
                            child: Center(
                                child: Text(
                              "변경 사항 적용 되었습니다.",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                              ),
                              textAlign: TextAlign.center,
                            )),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
