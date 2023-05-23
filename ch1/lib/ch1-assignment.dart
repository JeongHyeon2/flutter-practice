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
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Material Flutter App",
      theme: ThemeData(
        primarySwatch: Colors.yellow,
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
  int num = 0;
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title : Text("Material Design App")),
       floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () { 
           setState(() {
            num++;
        });}
      ),
      body: Container(
        child: Center(
          child: Column(
            children:<Widget>[
              Text("$num"),
            ElevatedButton(
            child : Text("reset"),
            onPressed : () {
              setState(() {
                    num=0;
              });
        
            }
          )
            ],
             mainAxisAlignment: MainAxisAlignment.center,
          )
        )
      )
    );
  }
}
