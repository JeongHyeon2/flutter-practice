import 'dart:math';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'create_screen.dart';
import 'home_screen.dart';
import 'list_screen.dart';
import 'main.dart';
import 'word.model.dart';

class MyData extends ChangeNotifier {
  final List<WordModel> _list = [];
  String separator = "|";
  String title;
  int indexInData;
  List<WordModel> get list => _list;
  MyData({
    required this.title,
    required this.indexInData,
  });

  void add(WordModel wordModel) {
    _list.add(wordModel);
    notifyListeners(); // 데이터 변경을 알림
    saveData();
  }

  void delete(int idx) {
    _list.removeAt(idx);
    notifyListeners(); // 데이터 변경을 알림
    saveData();
  }

  String listToString() {
    String result = "";
    result += "$title$separator";
    for (int i = 1; i < _list.length; i++) {
      result += "${_list[i].wordEng}$separator${_list[i].wordKor}$separator";
    }
    return result;
  }

  void saveData() async {
    items?[indexInData] = listToString();
    await prefs.setStringList('items', items ?? []);
  }
}

// ignore: must_be_immutable
class Screen extends StatefulWidget {
  late MyData myData;
  int idx = 0;
  int indexInData;
  bool _isChecked = true;
  bool isOpen = false;
  final String data;

  Screen({
    Key? key,
    required this.indexInData,
    required this.data,
  }) : super(key: key);

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  void initState() {
    widget.myData = MyData(
        indexInData: widget.indexInData, title: widget.data.split("|")[0]);
    widget.myData.list.add(const WordModel("영어단어", "뜻"));
    if (widget.data.split("|").length >= 2) {
      var arr = widget.data.split("|");
      for (int i = 1; i < arr.length - 1; i = i + 2) {
        widget.myData.list.add(WordModel(arr[i], arr[i + 1]));
      }
    }

    super.initState();
  }

  double initial = 0.0;
  double distance = 0.0;
  onTapGoToDictionary() async {
    final url = Uri.parse(
        "https://en.dict.naver.com/#/search?query=${widget.myData.list[widget.idx].wordEng}");
    if (widget.idx != 0) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    void navi() async {}
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.myData.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          GestureDetector(
            onTap: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    // AlertDialog의 속성들을 설정합니다
                    backgroundColor: Theme.of(context).cardColor,

                    title: const Text(
                      '기능',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ), // 팝업의 제목
                    content: SingleChildScrollView(
                      child: SizedBox(
                        height: 420, // 원하는 세로 크기
                        child: StatefulBuilder(
                          builder: (context, setState) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                      top: 10,
                                      bottom: 10,
                                    ),
                                    child: Text(
                                      '정답 공개',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                      bottom: 10,
                                    ),
                                    child: Switch(
                                      value: widget._isChecked,
                                      onChanged: (value) {
                                        setState(() {
                                          widget._isChecked = value;
                                        });
                                      },
                                      activeColor: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  bottom: 10,
                                ),
                                child: MyButton(
                                  icon: Icons.add,
                                  widget: widget,
                                  text: "단어 추가",
                                  onPressedFunction: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CreateWordScreen(
                                          myData: widget.myData,
                                        ),
                                      ),
                                    );
                                    setState(() {});
                                    Navigator.of(context).pop(); // 팝업 닫기
                                  },
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (widget.idx != 0) {
                                    setState(() {
                                      widget.myData.delete(widget.idx);
                                      widget.idx--;
                                    });
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  child: MyButton(
                                    icon: Icons.delete,
                                    widget: widget,
                                    text: "단어 삭제",
                                    onPressedFunction: () {
                                      String deleteWord = widget.myData.list
                                          .elementAt(widget.idx)
                                          .wordEng;
                                      if (widget.idx != 0) {
                                        setState(() {
                                          widget.myData.delete(widget.idx);
                                          widget.idx--;
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight:
                                                      Radius.circular(10)),
                                            ),
                                            backgroundColor: Colors.blue,
                                            duration:
                                                const Duration(seconds: 1),
                                            content: Text(
                                              "$deleteWord가 삭제되었습니다.",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  bottom: 10,
                                ),
                                child: MyButton(
                                  icon: Icons.book_outlined,
                                  widget: widget,
                                  text: "영어사전",
                                  onPressedFunction: () {
                                    onTapGoToDictionary();
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  bottom: 10,
                                ),
                                child: MyButton(
                                  icon: Icons.list,
                                  widget: widget,
                                  text: "리스트",
                                  onPressedFunction: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WordList(
                                          myData: widget.myData,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  bottom: 10,
                                ),
                                child: MyButton(
                                  icon: Icons.replay_rounded,
                                  widget: widget,
                                  text: "무작위",
                                  onPressedFunction: () {
                                    Random random = Random();
                                    int startIndex = 1; // 섞기를 시작할 인덱스
                                    if (widget.myData._list.length != 1) {
                                      for (var i = startIndex;
                                          i < widget.myData._list.length;
                                          i++) {
                                        var j =
                                            random.nextInt(i - startIndex + 1) +
                                                startIndex;
                                        var temp = widget.myData._list[i];
                                        widget.myData._list[i] =
                                            widget.myData._list[j];
                                        widget.myData._list[j] = temp;
                                      }
                                    }
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10)),
                                        ),
                                        backgroundColor: Colors.blue,
                                        duration: Duration(seconds: 1),
                                        content: Text(
                                          "단어를 무작위로 배열했습니다.",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    actions: [
                      // 팝업의 액션 버튼들을 설정합니다
                      TextButton(
                        child: const Text('확인'),
                        onPressed: () {
                          setState(() {});
                          Navigator.of(context).pop(); // 팝업 닫기
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: const Padding(
              padding: EdgeInsets.only(
                right: 10,
              ),
              child: Icon(
                Icons.settings,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onPanStart: (DragStartDetails details) {
          initial = details.globalPosition.dx;
        },
        onPanUpdate: (DragUpdateDetails details) {
          distance = details.globalPosition.dx - initial;
        },
        onPanEnd: (DragEndDetails details) {
          initial = 0.0;
          if (distance < -20) rightSwipe();
          if (distance > 20) leftSwipe();
        },
        child: Container(
          color: Theme.of(context).cardColor,
          child: GestureDetector(
            onPanStart: (DragStartDetails details) {
              initial = details.globalPosition.dx;
            },
            onPanUpdate: (DragUpdateDetails details) {
              distance = details.globalPosition.dx - initial;
            },
            onPanEnd: (DragEndDetails details) {
              if (distance > 100) {
                leftSwipe();
              } else if (distance < -100) {
                rightSwipe();
              }
            },
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (widget.idx).toString(),
                      style: const TextStyle(fontSize: 30),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 30 / 100,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 15,
                          left: 15,
                        ),
                        child: Text(
                          widget.myData.list[widget.idx].wordEng,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: leftSwipe,
                          child: const Icon(
                            Icons.keyboard_arrow_left_outlined,
                            size: 50,
                          ),
                        ),
                        GestureDetector(
                          onTap: rightSwipe,
                          child: const Icon(
                            Icons.keyboard_arrow_right_outlined,
                            size: 50,
                          ),
                        ),
                      ],
                    ),
                    if (!widget.isOpen && !widget._isChecked)
                      SizedBox(
                        height: 110,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 15,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                widget.isOpen = true;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(100, 50),
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text('정답'),
                          ),
                        ),
                      ),
                    if (widget.isOpen || widget._isChecked)
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 15,
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SizedBox(
                            height: 100,
                            child: Text(
                              widget.myData.list[widget.idx].wordKor,
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void rightSwipe() {
    setState(() {
      if (widget.idx != widget.myData.list.length - 1) {
        widget.idx++;
        widget.isOpen = false;
      }
      if (widget.idx == widget.myData.list.length - 1) {
        widget.idx = 0;
        widget.isOpen = false;
      }
    });
  }

  void leftSwipe() {
    setState(() {
      if (widget.idx != 0) {
        widget.idx--;
        widget.isOpen = false;
      }
      if (widget.idx == 0) {
        widget.idx = widget.myData.list.length - 1;
        widget.isOpen = false;
      }
    });
  }
}

class MyButton extends StatelessWidget {
  final String text;
  final Screen widget;
  final VoidCallback onPressedFunction;
  final IconData icon;

  const MyButton({
    Key? key,
    required this.widget,
    required this.text,
    required this.onPressedFunction,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: ElevatedButton.icon(
        onPressed: onPressedFunction,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(130, 50),
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        icon: Icon(icon),
        label: Text(text),
      ),
    );
  }
}
