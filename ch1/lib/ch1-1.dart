import 'package:flutter/material.dart';

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
    home: Container(
        color : Color.fromARGB(255, 64, 127, 211),
        child : Center(
          child : Text("hello world!", textAlign: TextAlign.center,style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 30),),
        )
      )
  
    );
  }
}