import 'package:flutter/material.dart';
import 'package:vocabulary/word.model.dart';

import 'detail_screen.dart';

class CreateWordScreen extends StatefulWidget {
  MyData myData;
  CreateWordScreen({
    Key? key,
    required this.myData,
  }) : super(key: key);

  @override
  State<CreateWordScreen> createState() => _CreateWordScreenState();
}

class _CreateWordScreenState extends State<CreateWordScreen> {
  List<String> list = [];
  String _enteredEng = '';
  String _enteredKor = '';
  final TextEditingController _textEditingController1 = TextEditingController();
  final TextEditingController _textEditingController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Create Word'),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Theme.of(context).cardColor,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: _textEditingController1,
                  onChanged: (value) {
                    _enteredEng = value;
                  },
                  style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: '영어 단어',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: _textEditingController2,
                  onChanged: (value) {
                    _enteredKor = value;
                  },
                  style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: '한국어',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      if (_enteredEng != "" && _enteredKor != "") {
                        widget.myData.add(WordModel(_enteredEng, _enteredKor));
                        _enteredEng = '';
                        _enteredKor = '';
                        _clearText();
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
                              "단어 추가 성공!",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      }
                    });
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('추가하기'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 60, 183, 255),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Text(list[index]);
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: list.length,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _clearText() {
    setState(() {
      _textEditingController1.clear();
      _textEditingController2.clear();
    });
  }
}
