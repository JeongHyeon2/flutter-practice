import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vocabulary/screen.dart';

import 'main.dart';

List<String>? items;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void loadItems() {
    if (prefs.getStringList('items') != null) {
      setState(() {
        items = prefs.getStringList('items')!;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  @override
  void dispose() {
    saveData();
    super.dispose();
  }

  void saveData() async {
    await prefs.setStringList('items', items ?? []);
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
                            TextButton(
                              child: const Text('확인'),
                              onPressed: () {
                                setState(() {
                                  String result = "";
                                  List<String> tmp =
                                      items!.elementAt(index).split(",");
                                  if (title.trim() == "") {
                                    tmp[0] = "제목없음";
                                  } else {
                                    tmp[0] = title;
                                  }
                                  for (int i = 0; i < tmp.length; i++) {
                                    result += "${tmp[i]},";
                                  }
                                  items![index] = result;
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Screen(
                        indexInData: index,
                        data: items!.elementAt(index),
                      ),
                    ),
                  );
                  setState(() {});
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          items!.elementAt(index).split(",")[0],
                          style: const TextStyle(fontSize: 25),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          String s = "";
                          if (index == 0) {
                            s = "정말 ${items?.elementAt(0).split(",")[0]} 을/를 삭제하시겠습니까?";
                          } else if (index > 0) {
                            s = "정말 ${items?.elementAt(index).split(",")[0]} 을/를 삭제하시겠습니까?";
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return AlertDialog(
                                  // AlertDialog의 속성들을 설정합니다
                                  title: const Text('삭제'), // 팝업의 제목
                                  content: Text(s),
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
                                          items?.removeAt(index);
                                          saveData();
                                          if (index != 0) index--;
                                        });
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Icon(
                            Icons.delete_forever_rounded,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              if (index < items!.length - 1) {
                // 마지막 아이템 다음에는 구분자를 생성하지 않음
                return const SizedBox(height: 1);
              } else {
                return const SizedBox(
                  height: 1,
                );
              }
            },
            itemCount: items?.length ?? 0),
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
                          TextButton(
                            child: const Text('확인'),
                            onPressed: () {
                              setState(() {
                                if (title.trim() == "") {
                                  items!.insert(0, "제목없음");
                                } else {
                                  items!.insert(0, title);
                                }
                                saveData();
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
