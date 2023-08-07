import 'package:flutter/material.dart';
import 'package:middle_class/common/layout/default_layout.dart';

class RootTab extends StatelessWidget {
  const RootTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
      child: Scaffold(
        body: Center(
          child: Text("root tab"),
        ),
      ),
    );
  }
}
