import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_test/common/layout/default_layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: "Home Screen",
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            ElevatedButton(
              onPressed: () => context.push("/StateProviderScreen"),
              child: const Text("StateProviderScreen"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => context.push("/StateNotifierProviderScreen"),
              child: const Text("StateNotifierProviderScreen"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => context.push("/FutureProviderScreen"),
              child: const Text("FutureProviderScreen"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => context.push("/FamilyModifierScreen"),
              child: const Text("FamilyModifierScreen"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => context.push("/AutoDisposeModifierScreen"),
              child: const Text("AutoDisposeModifierScreen"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => context.push("/ListenProviderScreen"),
              child: const Text("ListenProviderScreen"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => context.push("/SelectProviderScreen"),
              child: const Text("SelectProviderScreen"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => context.push("/ProviderScreen"),
              child: const Text("ProviderScreen"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => context.push("/CodeGenerationScreen"),
              child: const Text("CodeGenerationScreen"),
            ),
          ],
        ),
      ),
    );
  }
}
