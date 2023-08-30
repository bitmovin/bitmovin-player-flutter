import 'package:bitmovin_player_example/pages/analytics.dart';
import 'package:bitmovin_player_example/pages/fullscreen_handling.dart';
import 'package:flutter/material.dart';
import 'package:bitmovin_player_example/pages/basic_playback.dart';
import 'package:bitmovin_player_example/pages/event_subscription.dart';
import 'package:bitmovin_player_example/pages/audio_only.dart';
import 'package:bitmovin_player_example/pages/custom_html_ui.dart';
import 'package:bitmovin_player_example/pages/drm_playback.dart';

class Home extends StatelessWidget {
  static String routeName = 'Home';
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bitmovin Player Demo'),
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
                Navigator.of(context).pushNamed(AnalyticsExample.routeName);
              },
              child: const Text('Collecting Analytics'),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(BasicPlayback.routeName);
              },
              child: const Text('Basic Playback'),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(DrmPlayback.routeName);
              },
              child: const Text('DRM Playback'),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AudioOnly.routeName);
              },
              child: const Text('Audio Only'),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EventSubscription.routeName);
              },
              child: const Text('Event Subscription'),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CustomHtmlUi.routeName);
              },
              child: const Text('Custom HTML UI'),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(FullscreenHandling.routeName);
              },
              child: const Text('Fullscreen Handling'),
            ),
          ],
        ),
      ),
    );
  }
}
