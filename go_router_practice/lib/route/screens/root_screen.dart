import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_practice/layout/default_layout.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () {
              context.go('/basic');
            },
            child: const Text("Go Basic"),
          ),
          const SizedBox(
            height: 8,
          ),
          ElevatedButton(
            onPressed: () {
              context.goNamed('named_screen');
            },
            child: const Text("Go Named"),
          ),
          const SizedBox(
            height: 8,
          ),
          ElevatedButton(
            onPressed: () {
              context.go('/push');
            },
            child: const Text("Go Push"),
          ),
          const SizedBox(
            height: 8,
          ),
          ElevatedButton(
            onPressed: () {
              context.go('/pop');
            },
            child: const Text("Go Pop"),
          ),
          const SizedBox(
            height: 8,
          ),
          ElevatedButton(
            onPressed: () {
              context.go('/path_param/456');
            },
            child: const Text("Go PathParam"),
          ),
          const SizedBox(
            height: 8,
          ),
          ElevatedButton(
            onPressed: () {
              context.go('/query_param');
            },
            child: const Text("Go Query Parameter"),
          ),
        ],
      ),
    );
  }
}
