import 'package:flutter/material.dart';
import 'package:player_example/pages/basic_playback.dart';
import 'package:player_example/pages/basic_playback_with_event_subscription.dart';
import 'package:player_example/pages/basic_player_only.dart';
import 'package:player_example/pages/drm_playback.dart';
import 'package:player_example/pages/home.dart';
import 'package:player_example/pages/licensekey_via_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        Home.routeName: (_) => const Home(),
        BasicPlayback.routeName: (_) => const BasicPlayback(),
        DrmPlayback.routeName: (_) => const DrmPlayback(),
        BasicPlayerOnly.routeName: (_) => const BasicPlayerOnly(),
        BasicPlaybackWithEventSubscription.routeName: (_) =>
            const BasicPlaybackWithEventSubscription(),
        LicenseKeyViaConfig.routeName: (_) => const LicenseKeyViaConfig(),
      },
      home: const Scaffold(
        body: Home(),
      ),
    );
  }
}
