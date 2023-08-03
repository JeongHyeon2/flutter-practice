import 'package:flutter/material.dart';
import 'package:inflearn_practice/navigator/route_one_screen.dart';

import 'main_layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // true - pop 가능
        // false - pop 불가능
        // 작업실행
        final canPop = Navigator.of(context).canPop();

        return canPop;
      },
      child: MainLayout(
        title: 'Home Screen',
        children: [
          ElevatedButton(
            onPressed: () {
              print(Navigator.of(context).canPop());
            },
            child: const Text('Can Pop'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).maybePop();
            },
            child: const Text('Maybe Pop'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Pop'),
          ),
          ElevatedButton(
            onPressed: () async {
              final result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => const RouteOneScreen(
                    number: 123,
                  ),
                ),
              );

              print(result);
            },
            child: const Text('Push'),
          ),
        ],
      ),
    );
  }
}
