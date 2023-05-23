import 'package:ch3/sub/firstPage.dart';
import 'package:ch3/sub/secondPage.dart';
import 'package:flutter/material.dart';
import 'package:ch3/sub/animal.dart';

TabController? controller;
  // growable: 리스트가 가변적으로 증가할 수 있는지 true
  List<Animal> list = new List.empty(growable: true);
  


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  TabController? controller;
  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("네비게이션 테스트")),
      body: TabBarView(children: <Widget>[
        FirstPage(list: list),
        SecondPage(list: list),
      ], controller: controller),
      bottomNavigationBar: TabBar(tabs: <Tab>[
        Tab(icon: Icon(Icons.looks_one, color: Colors.blue)),
        Tab(icon: Icon(Icons.looks_two, color: Colors.blue))
      ], controller: controller),
    );
  }
   @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);

    list.add(Animal(imagePath: "image/bee.png", name: "벌", kind: "곤충"));
    list.add(Animal(imagePath: "image/cat.png", name: "고양이", kind: "포유류"));
    list.add(Animal(imagePath: "image/cow.png", name: "소", kind: "포유류"));
    list.add(Animal(imagePath: "image/dog.png", name: "강아지", kind: "포유류"));
    list.add(Animal(imagePath: "image/fox.png", name: "여우", kind: "포유류"));
    list.add(Animal(imagePath: "image/monkey.png", name: "원숭이", kind: "영장류"));
    list.add(Animal(imagePath: "image/pig.png", name: "돼지", kind: "포유류"));
    list.add(Animal(imagePath: "image/wolf.png", name: "늑대", kind: "포유류"));
  }
}