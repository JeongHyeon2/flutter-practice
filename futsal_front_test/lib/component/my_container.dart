import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  final Widget child;
  final String? title;
  final double width;
  final double height;
  const MyContainer({
    required this.child,
    this.title,
    required this.height,
    required this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[200]!,
          width: 2,
        ),
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200]!,
            blurRadius: 0.5,
            spreadRadius: 1.0,
            offset: const Offset(0.0, 7.0),
          )
        ],
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (title != null)
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  title!,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            child,
          ],
        ),
      ),
    );
  }
}
