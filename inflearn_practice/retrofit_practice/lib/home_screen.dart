import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'example.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                print("clicked!");
                final dio = Dio(); // Provide a dio instance

                final client = RestClient(dio);

                final data = await client.getTasks();
                print(data.length);
                print(data.map((e) => (e.toJson())));
              },
              child: const Text("get!"),
            ),
            ElevatedButton(
              onPressed: () async {
                print("clicked!");
                final dio = Dio(); // Provide a dio instance
                dio.options.headers["Demo-Header"] =
                    "demo header"; // config your dio headers globally

                final client = RestClient(dio);
                final task = Task(
                  date: DateTime.now(),
                  canGeneralUser: true,
                  scheduledTime: "3",
                  startTime: "14시 30분",
                );

                client.post(task);
              },
              child: const Text("post!"),
            ),
          ],
        ),
      ),
    );
  }
}
