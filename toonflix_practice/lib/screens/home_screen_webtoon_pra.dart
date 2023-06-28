import 'package:flutter/material.dart';

import '../models/webtoon_model_pra.dart';

class HomeScreenWebtoonPra extends StatefulWidget {
  const HomeScreenWebtoonPra({super.key});

  @override
  State<HomeScreenWebtoonPra> createState() => _HomeScreenWebtoonPraState();
}

class _HomeScreenWebtoonPraState extends State<HomeScreenWebtoonPra> {
  final Future<List<WebtoonModel>> webtoons = [WebtoonModel()];
  final Color mainBackColor = const Color.fromARGB(255, 102, 241, 174);
  final Color mainStringColor = const Color.fromARGB(255, 235, 235, 235);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: mainBackColor,
        title: Center(
          child: Text(
            "오늘의 웹툰",
            style: TextStyle(
              color: mainStringColor,
              fontWeight: FontWeight.w600,
              fontSize: 25,
            ),
          ),
        ),
        elevation: 4,
      ),
      body: Column(
        children: [
          FutureBuilder<List<WebtoonModel>>(
            future: webtoons,
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
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  ListView makeList(List<WebtoonModel>? data) {
    return ListView.separated(
      itemBuilder: (context, index) {
        var webtoon = data[index];
        return const Text("dd");
      },
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemCount: data!.length,
    );
  }
}
