import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/services/api_service.dart';

import '../widgets/webtoon_widget.dart';

class HomeScreenWebtoon extends StatelessWidget {
  HomeScreenWebtoon({super.key});
  /*
    data fecth
    stateful widget에서 사용 가능한 방법
    List<WebtoonModel> webtoons = [];
    bool isLoading = true;

    void waitForWebtoons() async  {
      webtoons = await ApiService.getTodaysToons();
      isLoading = false;
      setState(() {});
    }

    @override
    void initState() {
      super.initState();
      waitForWebtoons();
    }
  */

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Center(
          child: Text(
            "오늘의 웹툰",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        //음영
        elevation: 4,
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
      ),
      //stateful widget 대신 쓸 수 있는 위젯
      body: FutureBuilder<List<WebtoonModel>>(
        future: webtoons,
        // snapshot은 future의 상태를 알 수 있다.
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<WebtoonModel>? data = snapshot.data;
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                // expanded는 컬럼의 높이를 설정해줌.
                Expanded(
                  child: makeList(data),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView makeList(List<WebtoonModel>? data) {
    // item사이 구분자를 넣어줄 수 있는 위젯
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      scrollDirection: Axis.horizontal,
      itemCount: data!.length,
      // 사용자가 보는 item만 build한다. 그 위치를 index로 알려줌
      itemBuilder: (context, index) {
        var webtoon = data[index];
        return Webtoon(
          title: webtoon.title,
          thumb: webtoon.thumb,
          id: webtoon.id,
        );
      },
      //구분자
      separatorBuilder: (context, index) => const SizedBox(
        width: 40,
      ),
    );
  }
}
