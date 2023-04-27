import 'package:flutter/material.dart';
import 'package:player_example/pages/basic_playback.dart';
import 'package:player_example/pages/basic_player_only.dart';

class Home extends StatelessWidget {
  static String routeName = 'Home';
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bitmovin Sample'),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(BasicPlayback.routeName);
              },
              child: const Text('Basic Playback'),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(BasicPlayerOnly.routeName);
              },
              child: const Text('Basic Playback (Audio only)'),
            )
          ],
        ),
      ),
    );
  }
}
