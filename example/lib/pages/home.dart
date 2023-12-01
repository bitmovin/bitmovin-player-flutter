import 'dart:io';

import 'package:bitmovin_player_example/pages/analytics.dart';
import 'package:bitmovin_player_example/pages/audio_only.dart';
import 'package:bitmovin_player_example/pages/background_playback.dart';
import 'package:bitmovin_player_example/pages/basic_playback.dart';
import 'package:bitmovin_player_example/pages/casting.dart';
import 'package:bitmovin_player_example/pages/custom_html_ui.dart';
import 'package:bitmovin_player_example/pages/drm_playback.dart';
import 'package:bitmovin_player_example/pages/event_subscription.dart';
import 'package:bitmovin_player_example/pages/fullscreen_handling.dart';
import 'package:bitmovin_player_example/pages/picture_in_picture.dart';
import 'package:flutter/material.dart';

List<_Sample> _samples = [];
 
void buildSamples() {
  _samples = [
    _Sample('Collecting Analytics', PlayerAnalytics.routeName),
    _Sample('Basic Playback', BasicPlayback.routeName),
    _Sample('DRM Playback', DrmPlayback.routeName),
    _Sample('Audio Only', AudioOnly.routeName),
    _Sample('Event Subscription', EventSubscription.routeName),
    _Sample('Custom HTML UI', CustomHtmlUi.routeName),
    _Sample('Fullscreen Handling', FullscreenHandling.routeName),
    _Sample('Casting', Casting.routeName),
  ];

  if (Platform.isIOS) {
    _samples
      ..add(_Sample('Background Playback', BackgroundPlayback.routeName))
      ..add(_Sample('Picture-in-Picture', PictureInPicture.routeName));
  }
}

class Home extends StatelessWidget {
  Home({super.key}) {
    buildSamples();
  }
  static String routeName = 'Home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bitmovin Player Demo'),
      ),
      body: ListView.builder(
        itemCount: _samples.length,
        itemBuilder: (context, index) {
          final sample = _samples[index];
          return ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(sample.routeName);
            },
            trailing: const Icon(Icons.chevron_right),
            title: Text(sample.name),
          );
        },
      ),
    );
  }
}

class _Sample {
  const _Sample(this.name, this.routeName);

  final String name;
  final String routeName;
}
