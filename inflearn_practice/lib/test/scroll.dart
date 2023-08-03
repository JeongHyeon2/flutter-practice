import "package:flutter/material.dart";

void main() {
  runApp(
    const MaterialApp(
      home: HomeScreen(),
    ),
  );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: colors
              .map(
                (e) => myContainer(e),
              )
              .toList(),
        ),
      ),
    );
  }
}

Container myContainer(Color? color) {
  return Container(
    color: color,
    height: 300,
  );
}

final colors = [
  Colors.red,
  Colors.amber,
  Colors.yellow,
  Colors.green,
  Colors.blue,
  Colors.blue[900],
  Colors.purple,
];
