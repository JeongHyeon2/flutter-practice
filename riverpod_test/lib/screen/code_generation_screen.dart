import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/common/layout/default_layout.dart';

import '../riverpod/code_generation_provider.dart';

class CodeGenerationScreen extends ConsumerWidget {
  const CodeGenerationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state1 = ref.watch(gStateProvider);
    final state2 = ref.watch(gStateFutureProvider);
    final state3 = ref.watch(gStateFuture2Provider);
    final state4 = ref.watch(gStateMultiplyProvider(number1: 10, number2: 20));
    return DefaultLayout(
      title: "CodeGenerationScreen",
      child: Column(
        children: [
          Text('State1 : $state1'),
          state2.when(
            data: (value) => Text('State2 : ${value.toString()}'),
            error: (error, stack) => Text(error.toString()),
            loading: () => const CircularProgressIndicator(),
          ),
          state3.when(
            data: (value) => Text('State3 : ${value.toString()}'),
            error: (error, stack) => Text(error.toString()),
            loading: () => const CircularProgressIndicator(),
          ),
          Text('State4 : $state4'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () =>
                    ref.read(gStateNotifierProvider.notifier).decrement(),
                child: const Text("감소"),
              ),
              Consumer(
                builder: (context, ref, child) {
                  final state5 = ref.watch(gStateNotifierProvider);
                  return Row(children: [child!, Text('State5 : $state5')]);
                },
                child: const Text('Hello'),
              ),
              ElevatedButton(
                onPressed: () =>
                    ref.read(gStateNotifierProvider.notifier).increment(),
                child: const Text(
                  "증가",
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () => ref.invalidate(gStateNotifierProvider), // 초기화
            child: const Text("Invalidate state5"),
          ),
        ],
      ),
    );
  }
}
