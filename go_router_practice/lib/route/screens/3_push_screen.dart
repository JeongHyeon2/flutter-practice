import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_practice/layout/default_layout.dart';

class PushScreen extends StatelessWidget {
  const PushScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () {
              context.push('/basic');
            },
            child: const Text('push basic'),
          ),
          const SizedBox(
            height: 8,
          ),
          ElevatedButton(
            onPressed: () {
              context.go('/basic');
            },
            child: const Text('go basic'),
          ),
        ],
      ),
    );
  }
}
