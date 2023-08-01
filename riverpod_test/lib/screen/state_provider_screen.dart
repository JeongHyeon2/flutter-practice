import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_test/common/layout/default_layout.dart';
import 'package:riverpod_test/riverpod/state_provider.dart';

class StateProviderScreen extends ConsumerWidget {
  const StateProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(numberProvider);
    return DefaultLayout(
      title: "State Provider Screen",
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Text(provider.toString())),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => ref
                  .read(numberProvider.notifier)
                  .update((state) => state + 1),
              child: const Text("증가"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => ref.read(numberProvider.notifier).state--,
              child: const Text("감소"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const _NextScreen()),
              ),
              child: const Text("Next"),
            ),
          ],
        ),
      ),
    );
  }
}

class _NextScreen extends ConsumerWidget {
  const _NextScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(numberProvider);
    return DefaultLayout(
      title: "State Provider Screen",
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Text(provider.toString())),
              ElevatedButton(
                onPressed: () => ref
                    .read(numberProvider.notifier)
                    .update((state) => state + 1),
                child: const Text("증가"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
