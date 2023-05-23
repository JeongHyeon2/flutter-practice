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
Widget build(BuildContext context){
		var buttonWidth = MediaQuery.of(context).size.width;
    var buttonHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text("image widget"),
        ),
        body: Container(
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
              // EdgeInsets.only(left: 50, right: 50, top: 50, bottom: 50)
              TextButton(
                onPressed: () {
                  // Respond to button press
                },
                style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                  fixedSize: Size(buttonWidth, buttonHeight / 4),
                    ),
                child: Text("TEXT BUTTON"),
              ),
              OutlinedButton(
                onPressed: () {
                  // Respond to button press
                },
                style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.blue,
                      fixedSize: Size(buttonWidth, buttonHeight / 4),

                    ),
                child: Text("OUTLINED BUTTON"),
              ),
              ElevatedButton(
                onPressed: () {
                  // Respond to button press
                },
                style: OutlinedButton.styleFrom(
                     backgroundColor: Colors.blue,
                      fixedSize: Size(buttonWidth, buttonHeight / 4),

                    ),
                child: Text('CONTAINED BUTTON'),
              )
            ]))));
  }
}
