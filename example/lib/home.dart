import 'package:flutter/material.dart';
import 'package:player_example/pages/player_with_config.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlayerWithConfig(),
                  ),
                );
              },
              child: const Text('Player with config'),
            ),
          ],
        ),
      ),
    );
  }
}
