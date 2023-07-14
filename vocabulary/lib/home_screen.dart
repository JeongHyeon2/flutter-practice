import 'dart:ui';
import 'package:wakelock/wakelock.dart';
import 'package:flutter/material.dart';
import 'detail_screen.dart';
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
    print(items);
    Wakelock.enable();
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
      theme: ThemeData(
        cardColor: const Color.fromARGB(255, 231, 231, 231),
      ),
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      home: const MyWidget(),
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

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  void saveData() async {
    await prefs.setStringList('items', items ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        title: const Center(
          child: Text(
            "영어 단어장",
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
      ),
      body: ReorderableListView(
        children: <Widget>[
          for (int index = 0; index < items!.length; index += 1)
            ListTile(
              key: Key('$index'), // 인덱스를 기반으로 고유한 key 할당
              tileColor: Colors.transparent,
              title: Padding(
                padding: const EdgeInsets.only(
                  bottom: 5,
                  top: 5,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
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
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 5,
                        ),
                        child: Icon(
                          Icons.table_rows_rounded,
                          size: 30,
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onLongPress: () {
                            String title = "";
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                var item = items!.elementAt(index);
                                return AlertDialog(
                                  title: const Text(
                                    "제목 수정",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
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
                                        vertical: 10,
                                        horizontal: 20,
                                      ),
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('취소'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('확인'),
                                      onPressed: () {
                                        setState(() {
                                          String result = "";
                                          List<String> tmp = item.split("|");
                                          tmp[0] = title.trim() == ""
                                              ? "제목없음"
                                              : title;

                                          for (int i = 0; i < tmp.length; i++) {
                                            result += "${tmp[i]}|";
                                          }
                                          items![index] = result;
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              items!.elementAt(index).split("|")[0],
                              style: const TextStyle(fontSize: 25),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          String s = "";
                          s = "정말 ${items?.elementAt(index).split("|")[0]} 을/를 삭제하시겠습니까?";
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text(
                                  '삭제',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                content: Text(s),
                                actions: [
                                  TextButton(
                                    child: const Text('취소'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('확인'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
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
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.delete_forever_rounded,
                            size: 35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

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
            ),
        ],
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final String item = items!.removeAt(oldIndex);
            items!.insert(newIndex, item);
            saveData();
          });
        },
      ),
      floatingActionButton: Builder(
        builder: (BuildContext context) {
          return FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  String title = "";
                  return AlertDialog(
                    // AlertDialog의 속성들을 설정합니다
                    title: const Text(
                      '알림',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ), // 팝업의 제목
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
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      ),
                    ), // 팝업의 내용
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
                          setState(() {
                            items!
                                .insert(0, title.trim() == "" ? "제목없음" : title);
                            saveData();
                          });
                          Navigator.of(context).pop(); // 팝업 닫기
                        },
                      ),
                    ],
                  );
                },
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
    );
  }
}
