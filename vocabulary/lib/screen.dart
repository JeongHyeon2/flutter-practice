import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vocabulary/create_screen.dart';
import 'home_screen.dart';
import 'word.model.dart';

class MyData extends ChangeNotifier {
  final List<WordModel> _list = [];
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
    result += "$title,";
    for (int i = 1; i < _list.length; i++) {
      result += "${_list[i].wordEng},${_list[i].wordKor},";
    }
    return result;
  }

  void saveData() {
    data[indexInData] = listToString();
  }
}

class Screen extends StatefulWidget {
  //List<WordModel> list = [];
  late MyData myData;
  int idx = 0;
  int indexInData;
  bool _isChecked = false;
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
        indexInData: widget.indexInData, title: widget.data.split(",")[0]);
    widget.myData.list.add(WordModel(widget.myData.title, "-"));
    if (widget.data.split(",").length < 2) {
    } else {
      var arr = widget.data.split(",");
      for (int i = 1; i < arr.length - 1; i = i + 2) {
        widget.myData.list.add(WordModel(arr[i], arr[i + 1]));
      }
    }

    super.initState();
  }

  double initial = 0.0;
  double distance = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
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
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                              widget.myData.title = "제목없음";
                            } else {
                              widget.myData.title = title;
                              widget.myData.saveData();
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
          child: Text(widget.myData.title),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () async {
                  final url = Uri.parse(
                      "https://en.dict.naver.com/#/search?query=${widget.myData.list[widget.idx].wordEng}");
                  if (widget.idx != 0) {
                    await launchUrl(url);
                  }
                },
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 80, 168, 240),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 15,
                        offset: const Offset(10, 10),
                        color: Colors.black.withOpacity(0.5),
                      )
                    ],
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "영어사전 바로가기",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 55 / 100,
              width: MediaQuery.of(context).size.width,
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return GestureDetector(
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
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black, // 테두리 색상
                            width: 2.0, // 테두리 두께
                          ),
                        ),
                        color: Color.fromARGB(255, 231, 231, 231),
                      ),
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              (widget.idx).toString(),
                              style: const TextStyle(fontSize: 30),
                            ),
                          ),
                          const SizedBox(
                            height: 70,
                          ),
                          Text(
                            widget.myData.list[widget.idx].wordEng,
                            style: const TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: leftSwipe,
                                child: const Icon(
                                  Icons.keyboard_arrow_left_outlined,
                                  size: 50,
                                ),
                              ),
                              SizedBox(
                                height: 60,
                                width: constraints.maxWidth - 120,
                              ),
                              GestureDetector(
                                onTap: rightSwipe,
                                child: const Icon(
                                  Icons.keyboard_arrow_right_outlined,
                                  size: 50,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                          Visibility(
                            visible: widget.isOpen || widget._isChecked,
                            child: Text(
                              widget.myData.list[widget.idx].wordKor,
                              style: const TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: !widget.isOpen && !widget._isChecked,
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
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 40 / 100,
                color: const Color.fromARGB(255, 231, 231, 231),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CreateWordScreen(
                                          myData: widget.myData,
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(100, 50),
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: const Text('단어 추가'),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {});
                                  },
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(100, 50),
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: const Text('리스트'),
                                ),
                              ),
                              Row(
                                children: [
                                  const Text(
                                    '정답 공개',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20),
                                  ),
                                  Switch(
                                    value: widget._isChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        widget._isChecked = value;
                                      });
                                    },
                                    activeColor: Colors.blue,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (widget.idx != 0) {
                                      setState(() {
                                        widget.myData.delete(widget.idx);
                                        widget.idx--;
                                      });
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(100, 50),
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: const Text('단어 삭제'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void rightSwipe() {
    setState(() {
      if (widget.idx != widget.myData.list.length - 1) {
        widget.idx++;
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
    });
  }
}
