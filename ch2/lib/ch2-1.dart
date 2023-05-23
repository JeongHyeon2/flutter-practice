import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  String _title = "Kumoh42 Flutter App";
  MaterialColor _backgroundColor = Colors.red;

  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: _backgroundColor,
      ),
      home: MaterialFlutterApp(),
    );
  }
}

class MaterialFlutterApp extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _MaterialFlutterApp();
  }
}

class _MaterialFlutterApp extends State<MaterialFlutterApp> {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("image widget"),
        ),
        body: Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                // EdgeInsets.only(left: 50, right: 50, top: 50, bottom: 50)
                child: Image.asset("image/image.png",
                    width: 200, height: 300, fit: BoxFit.cover),
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "이름 : 김정현",
                        style: TextStyle(fontFamily: "Font", fontSize: 30),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "나이 : 22살",
                        style: TextStyle(fontFamily: "Font", fontSize: 30),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "학번 : 20200284",
                        style: TextStyle(fontFamily: "Font", fontSize: 30),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "소속 : 병무청",
                        style: TextStyle(fontFamily: "Font", fontSize: 30),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "좌우명 : \n없음",
                        style: TextStyle(fontFamily: "Font", fontSize: 30),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "자기 소개 : \n 안녕하십니까, 김정현입니다.",
                        style: TextStyle(fontFamily: "Font", fontSize: 30),
                      ),
                    )
                  ])
            ])));
  }
}
