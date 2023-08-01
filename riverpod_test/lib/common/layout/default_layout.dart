import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final String? title;
  final Color backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget child;
  final List<Widget>? actions;

  const DefaultLayout({
    Key? key,
    this.title,
    this.backgroundColor = Colors.white,
    this.bottomNavigationBar,
    this.actions,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: backgroundColor,
      body: SafeArea(
        top: true,
        bottom: false,
        child: child,
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  AppBar? _appBar() => title == null
      ? null
      : AppBar(
          actions: actions,
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            title!,
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          foregroundColor: Colors.black,
        );
}
