// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:bitmovin_sdk/player.dart';
import 'package:flutter/material.dart';

class PlayerWithConfig extends StatelessWidget {
  PlayerWithConfig({super.key});

  PlayerController? player;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              TextButton(
                onPressed: () {
                  player?.play();
                },
                child: const Text('PLAY'),
              ),
              TextButton(
                onPressed: () {
                  player?.pause();
                },
                child: const Text('PAUSE'),
              ),
              TextButton(
                onPressed: () {
                  player?.loadWithSourceConfig(
                    SourceConfig(
                      url: Platform.isAndroid ? "https://bitmovin-a.akamaihd.net/content/MI201109210084_1/mpds/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.mpd" : 'https://bitmovin-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8',
                      type: Platform.isAndroid ? SourceType.dash : SourceType.hls,
                      posterSource: 'https://bitmovin-a.akamaihd.net/content/MI201109210084_1/poster.jpg',
                      isPosterPersistent: false,
                    ),
                  );
                },
                child: const Text('LOAD'),
              ),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 360,
            child: PlayerView(
              playerConfig: const PlayerConfig(
                playbackConfig: PlaybackConfig(
                  isAutoplayEnabled: false,
                ),
              ),
              onPlayerCreated: (PlayerController controller) {
                player = controller;
              },
            ),
          ),
        ],
      ),
    );
  }
}
