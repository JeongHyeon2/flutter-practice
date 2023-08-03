import 'package:flutter/material.dart';
import 'package:inflearn_practice/navigator/route_two_screen.dart';
import 'main_layout.dart';

class RouteOneScreen extends StatelessWidget {
  final int? number;

  const RouteOneScreen({
    this.number,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Route One',
      children: [
        Text(
          'arguments : ${number.toString()}',
          textAlign: TextAlign.center,
        ),
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
            Navigator.of(context).pop(456);
          },
          child: const Text('Pop'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const RouteTwoScreen(),
                settings: const RouteSettings(
                  arguments: 789,
                ),
              ),
            );
          },
          child: const Text('Push'),
        ),
      ],
    );
  }
}
