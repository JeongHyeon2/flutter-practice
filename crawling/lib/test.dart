import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

late String s;
void main() async {
  final response = await http.get(Uri.parse(
      'https://sports.news.naver.com/wfootball/news/index?isphoto=N&type=popular'));

  dom.Document html = dom.Document.html(response.body);
  final result = html.body?.querySelector("#_newsList");
  print(html.outerHtml);

  runApp(const MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Text("hi!!"),
      ),
    );
  }
}
