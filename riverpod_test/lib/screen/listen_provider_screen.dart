import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/common/layout/default_layout.dart';
import 'package:riverpod_test/riverpod/listen_provider.dart';

class ListenProviderScreen extends ConsumerStatefulWidget {
  const ListenProviderScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ListenProviderScreen> createState() =>
      _ListenProviderScreenState();
}

class _ListenProviderScreenState extends ConsumerState<ListenProviderScreen>
    with TickerProviderStateMixin {
  late final TabController controller;

  @override
  void initState() {
    controller = TabController(
      length: 10,
      vsync: this,
      initialIndex: ref.read(listenProvider),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(listenProvider, (previous, next) => controller.animateTo(next));
    return DefaultLayout(
      title: 'ListenProviderScreen',
      child: TabBarView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
          10,
          (index) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () => ref
                      .read(listenProvider.notifier)
                      .update((state) => state == 0 ? 9 : state - 1),
                  child: const Text("이전")),
              const SizedBox(width: 10),
              Text(index.toString()),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => ref
                    .read(listenProvider.notifier)
                    .update((state) => state == 9 ? 0 : state + 1),
                child: const Text("이전"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
