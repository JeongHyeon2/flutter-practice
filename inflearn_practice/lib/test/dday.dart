import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: "sunflower",
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Colors.white,
            fontFamily: "parisienne",
            fontSize: 80,
          ),
          displayMedium: TextStyle(
            color: Colors.white,
            fontSize: 50,
            fontWeight: FontWeight.w700,
          ),
          bodyLarge: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
          bodyMedium: TextStyle(
            color: Colors.white,
            fontSize: 50,
          ),
        ),
      ),
      home: const HomeScreen(),
    ),
  );
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: SafeArea(
        bottom: false,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              _TopPart(
                selectedDate: selectedDate,
                onPressed: onHeartPress,
              ),
              const _BottomPart(),
            ],
          ),
        ),
      ),
    );
  }

  onHeartPress() {
    final now = DateTime.now();
    showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            height: 300,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: selectedDate,
              maximumDate: DateTime(
                now.year,
                now.month,
                now.day,
              ),
              onDateTimeChanged: (value) {
                setState(() {
                  selectedDate = value;
                });
              },
            ),
          ),
        );
      },
    );
  }
}

class _BottomPart extends StatelessWidget {
  const _BottomPart();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Image.asset(
        "asset/img/middle_image.png",
      ),
    );
  }
}

class _TopPart extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onPressed;
  const _TopPart({
    required this.onPressed,
    required this.selectedDate,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final now = DateTime.now();
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "U&I",
            style: textTheme.displayLarge,
          ),
          Column(
            children: [
              Text(
                "우리 처음 만난 날",
                style: textTheme.displayMedium,
              ),
              Text(
                "${selectedDate.year}.${selectedDate.month}.${selectedDate.day}",
                style: textTheme.bodyLarge,
              ),
            ],
          ),
          IconButton(
            iconSize: 60,
            onPressed: onPressed,
            icon: const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
          ),
          Text(
            "D+${DateTime(
                  now.year,
                  now.month,
                  now.day,
                ).difference(selectedDate).inDays + 1}",
            style: textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
