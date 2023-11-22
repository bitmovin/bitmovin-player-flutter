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
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).orientation == Orientation.landscape
            ? 200
            : double.infinity,
      ),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: PlayerView(
          player: player,
        ),
      ),
    );
  }
}
