import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vocabulary/screen.dart';

List<String> data = [];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    data.add(
        "Test1, apple, 사과, banana, 바나나, grape, 포도, ramen, 라면, int , 정수, flutter, 플러터");
    data.add("Test2,a, 에이, b, 비, c , 씨 , d , 디");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 231, 231, 231),
        appBar: AppBar(
          title: const Center(
            child: Text("앱바"),
          ),
        ),
        body: ListView.separated(
            itemBuilder: (context, index) {
              return GestureDetector(
                onLongPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AlertDialog(
                          // AlertDialog의 속성들을 설정합니다
                          title: const Text('삭제'), // 팝업의 제목
                          content: Text(
                              "정말 ${data[index].split(",")[0]} 을/를 삭제하시겠습니까?"),
                          actions: [
                            // 팝업의 액션 버튼들을 설정합니다
                            TextButton(
                              child: const Text('취소'),
                              onPressed: () {
                                Navigator.of(context).pop(); // 팝업 닫기
                              },
                            ),
                            TextButton(
                              child: const Text('확인'),
                              onPressed: () {
                                Navigator.of(context).pop(); // 팝업 닫기
                                setState(() {
                                  data.removeAt(index);
                                });
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  );
                },
                onTap: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Screen(
                          indexInData: index,
                          data: data[index],
                        ),
                      ),
                    );
                  });
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 60, 183, 255),
                  ),
                  height: 60,
                  child: Center(
                    child: Text(data[index].split(",")[0]),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              if (index < data.length - 1) {
                // 마지막 아이템 다음에는 구분자를 생성하지 않음
                return const SizedBox(height: 1);
              } else {
                return const SizedBox(
                  height: 1,
                );
              }
            },
            itemCount: data.length),
        floatingActionButton: Builder(
          builder: (BuildContext context) {
            return FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      String title = "";
                      return AlertDialog(
                        // AlertDialog의 속성들을 설정합니다
                        title: const Text('알림'), // 팝업의 제목
                        content: TextField(
                          onChanged: (value) {
                            title = value;
                          },
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: '제목',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                          ),
                        ), // 팝업의 내용
                        actions: [
                          // 팝업의 액션 버튼들을 설정합니다
                          // 팝업의 액션 버튼들을 설정합니다
                          TextButton(
                            child: const Text('확인'),
                            onPressed: () {
                              setState(() {
                                if (title.trim() == "") {
                                  data.add("제목없음");
                                } else {
                                  data.add(title);
                                }
                              });
                              Navigator.of(context).pop(); // 팝업 닫기
                            },
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
              backgroundColor: const Color.fromARGB(255, 60, 183, 255),
              child: const Icon(
                Icons.add,
                size: 40,
              ),
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

class JsonForWord {
  final String wordEng, wordKor;
  JsonForWord.fromJson(Map<String, dynamic> json)
      : wordEng = json['wordEng'],
        wordKor = json['wordKor'];
}
