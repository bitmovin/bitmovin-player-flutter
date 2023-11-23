import 'package:flutter/material.dart';
import 'package:bitmovin_player/bitmovin_player.dart';

class PlayerViewContainer extends StatelessWidget {
  const PlayerViewContainer({
    required this.player,
    super.key,
  });
  final Player player;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: PlayerView(
        player: player,
      ),
    );
  }
}
