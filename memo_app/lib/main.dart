import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MemoApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MemoApp extends StatefulWidget {
  const MemoApp({super.key});

  @override
  _MemoAppState createState() => _MemoAppState();
}

class _MemoAppState extends State<MemoApp> with WidgetsBindingObserver {
  final TextEditingController _memoController = TextEditingController();
  String _memoText = "";
  double _progressValue = 15;

  @override
  void initState() {
    super.initState();
    _loadMemo();
    _memoController.addListener(() {
      _saveMemo(_memoController.text);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _memoController.dispose();
  }

  Future<void> _loadMemo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _memoText = prefs.getString('memo') ?? "";
      _memoController.text = _memoText;
      _progressValue = prefs.getDouble("text_size") ?? 15;
    });
  }

  Future<void> _saveMemo(String text) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('memo', text);
    await prefs.setDouble("text_size", _progressValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: const Text(
          '메모장',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 12,
            ),
            child: IconButton(
              splashRadius: 20,
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return AlertDialog(
                          title: const Text('글자 크기'),
                          content: SizedBox(
                            width: 50,
                            height: 50,
                            child: Slider(
                              value: _progressValue,
                              onChanged: (newValue) {
                                setState(() {
                                  _progressValue = newValue;
                                });
                              },
                              min: 5,
                              max: 50,
                              divisions: 10, // 슬라이더의 분할 수
                              label: _progressValue
                                  .toStringAsFixed(2), // 슬라이더 값 위에 표시될 레이블
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                final prefs =
                                    await SharedPreferences.getInstance();

                                await prefs.setDouble(
                                    "text_size", _progressValue);

                                // 다이얼로그를 닫습니다.
                                Navigator.of(context).pop();
                              },
                              child: const Text('확인'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
                setState(() {});
              },
              icon: const Icon(
                Icons.settings,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _memoController,
            style: TextStyle(
              fontSize: _progressValue,
            ),

            maxLines: 200, // 여러 줄 메모 입력 가능
            onChanged: (text) {
              setState(() {
                _memoText = text;
              });
            },
            decoration: const InputDecoration(
              hintText: '메모를 입력하세요',
            ),
          ),
        ),
      ),
    );
  }
}
