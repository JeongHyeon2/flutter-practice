import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_test/riverpod/provider_observer.dart';
import 'package:riverpod_test/screen/auto_dispose_modifier_screen.dart';
import 'package:riverpod_test/screen/code_generation_screen.dart';
import 'package:riverpod_test/screen/family_modifier_screen.dart';
import 'package:riverpod_test/screen/future_provider_screen.dart';
import 'package:riverpod_test/screen/home_screen.dart';
import 'package:riverpod_test/screen/listen_provider_screen.dart';
import 'package:riverpod_test/screen/provider_screen.dart';
import 'package:riverpod_test/screen/select_provider_screen.dart';
import 'package:riverpod_test/screen/state_notifier_provider_screen.dart';
import 'package:riverpod_test/screen/state_provider_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: "StateProviderScreen",
            builder: (context, state) => const StateProviderScreen(),
          ),
          GoRoute(
            path: "StateNotifierProviderScreen",
            builder: (context, state) => const StateNotifierProviderScreen(),
          ),
          GoRoute(
            path: "FutureProviderScreen",
            builder: (context, state) => const FutureProviderScreen(),
          ),
          GoRoute(
            path: "FamilyModifierScreen",
            builder: (context, state) => const FamilyModifierScreen(),
          ),
          GoRoute(
            path: "AutoDisposeModifierScreen",
            builder: (context, state) => const AutoDisposeModifierScreen(),
          ),
          GoRoute(
            path: "ListenProviderScreen",
            builder: (context, state) => const ListenProviderScreen(),
          ),
          GoRoute(
            path: "SelectProviderScreen",
            builder: (context, state) => const SelectProviderScreen(),
          ),
          GoRoute(
            path: "ProviderScreen",
            builder: (context, state) => const ProviderScreen(),
          ),
          GoRoute(
            path: "CodeGenerationScreen",
            builder: (context, state) => const CodeGenerationScreen(),
          ),
        ],
      ),
    ],
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      observers: [
        Logger(),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        routerConfig: _router,
      ),
    );
  }
}
