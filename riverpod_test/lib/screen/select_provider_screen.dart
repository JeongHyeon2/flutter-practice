import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/common/layout/default_layout.dart';
import 'package:riverpod_test/riverpod/select_provider.dart';

class SelectProviderScreen extends ConsumerWidget {
  const SelectProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('build');
    final state = ref.watch(selectProvider.select((value) => value.isSpicy));
    ref.listen(selectProvider.select((value) => value.hasBought),
        (previous, next) => print('next: $next'));
    return DefaultLayout(
      title: "SelectProviderScreen",
      child: Column(
        children: [
          // Text(state.name),
          // Text(state.hasBought.toString()),
          // Text(state.isSpicy.toString()),
          Text(state.toString()),
          ElevatedButton(
            onPressed: () => ref.read(selectProvider.notifier).toggleIsSpicy(),
            child: const Text("Spicy Toggle"),
          ),
          ElevatedButton(
            onPressed: () =>
                ref.read(selectProvider.notifier).toggleHasBought(),
            child: const Text("HasBought Toggle"),
          ),
        ],
      ),
    );
  }
}
