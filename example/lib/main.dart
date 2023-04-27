import 'package:flutter/material.dart';
import 'package:player_example/pages/basic_playback.dart';
import 'package:player_example/pages/basic_player_only.dart';
import 'package:player_example/pages/home.dart';

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
        BasicPlayerOnly.routeName: (_) => const BasicPlayerOnly(),
      },
      home: const Scaffold(
        body: Home(),
      ),
    );
  }
}
