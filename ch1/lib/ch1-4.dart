import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Material Flutter App",
      theme: ThemeData(
        primarySwatch: Colors.red,
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
      appBar: AppBar(title : Text("Material Design App")),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {}
      ),
      body: Container(
        child: Center(
          child: Column(
            children:<Widget>[
            Icon(Icons.android),
            Text("android"),
            ],
             mainAxisAlignment: MainAxisAlignment.center,
          )
        )
      )
    );
  }
}