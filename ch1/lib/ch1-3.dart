import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {

  var switchValue = false;
  String test = "hello";

  Color _color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.light(),
      home: Scaffold(
        body: Center(
          child : ElevatedButton(
            child : Text("$test"),
               style : ButtonStyle(
              backgroundColor: MaterialStateProperty.all(_color)
            ),
            onPressed : () {
              if(test == "hello"){
                setState((){
                  test = "flutter";
                  _color = Colors.red;
                });
              }else {
                setState((){
                  test = "hello";
                  _color = Colors.blue;
                });
              } 
            }
          )
        )
      )
    );
  }
}