import 'package:bitmovin_player_example/pages/analytics.dart';
import 'package:bitmovin_player_example/pages/audio_only.dart';
import 'package:bitmovin_player_example/pages/background_playback.dart';
import 'package:bitmovin_player_example/pages/basic_picture_in_picture.dart';
import 'package:bitmovin_player_example/pages/basic_playback.dart';
import 'package:bitmovin_player_example/pages/casting.dart';
import 'package:bitmovin_player_example/pages/custom_html_ui.dart';
import 'package:bitmovin_player_example/pages/drm_playback.dart';
import 'package:bitmovin_player_example/pages/event_subscription.dart';
import 'package:bitmovin_player_example/pages/fullscreen_handling.dart';
import 'package:bitmovin_player_example/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

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
        Home.routeName: (_) => Home(),
        PlayerAnalytics.routeName: (_) => const PlayerAnalytics(),
        BasicPlayback.routeName: (_) => const BasicPlayback(),
        DrmPlayback.routeName: (_) => const DrmPlayback(),
        AudioOnly.routeName: (_) => const AudioOnly(),
        EventSubscription.routeName: (_) => const EventSubscription(),
        CustomHtmlUi.routeName: (_) => const CustomHtmlUi(),
        FullscreenHandling.routeName: (_) => const FullscreenHandling(),
        Casting.routeName: (_) => const Casting(),
        BackgroundPlayback.routeName: (_) => const BackgroundPlayback(),
        PictureInPicture.routeName: (_) => const PictureInPicture(),
      },
      home: Scaffold(
        body: Home(),
      ),
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          color: Color(0xFF006AED),
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}
