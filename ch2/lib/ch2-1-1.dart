import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
	
	String _title = "Kumoh42 Flutter App";	
	MaterialColor _backgroundColor = Colors.red;

  Widget build(BuildContext context){
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: _backgroundColor,
      ),
      home: MaterialFlutterApp(),
    );
  }
}

class MaterialFlutterApp extends StatefulWidget{
  State<StatefulWidget> createState(){
    return _MaterialFlutterApp();
  }
}

class _MaterialFlutterApp extends State<MaterialFlutterApp> {
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("image widget"),),
      body: Container(
        child: Center(
          	child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(50),
											// EdgeInsets.only(left: 50, right: 50, top: 50, bottom: 50)
                child: Image.asset("image/logo.png", width: 200, height: 50, fit: BoxFit.fill),
              ),
              Column(
               
                children:<Widget>[
              Text("hello", style: TextStyle(fontFamily: "Pacifico"),),
               Text("hello", style: TextStyle(fontFamily: "Pacifico"),),
                Text("hello", style: TextStyle(fontFamily: "Pacifico"),)
                ]
              )
            ]
          )
        )
      )
    );
  }
}