import 'package:flutter/material.dart';

typedef ControlAction = void Function()?;

class Controls extends StatelessWidget {
  const Controls({
    super.key,
    required this.onPlayPressed,
    required this.onPausePressed,
    required this.onLoadPressed,
    required this.onMutePressed,
    required this.onUnmutePressed,
    required this.onSkipForwardPressed,
  });

  final ControlAction onPlayPressed;
  final ControlAction onPausePressed;
  final ControlAction onLoadPressed;
  final ControlAction onMutePressed;
  final ControlAction onUnmutePressed;
  final ControlAction onSkipForwardPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton(
              onPressed: onPlayPressed,
              child: const Text('Play'),
            ),
            OutlinedButton(
              onPressed: onPausePressed,
              child: const Text('Pause'),
            ),
            OutlinedButton(
              onPressed: onLoadPressed,
              child: const Text('Load'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton(
              onPressed: onMutePressed,
              child: const Text('Mute'),
            ),
            OutlinedButton(
              onPressed: onUnmutePressed,
              child: const Text('Unmute'),
            ),
            OutlinedButton(
              onPressed: onSkipForwardPressed,
              child: const Text('Skip Forward'),
            ),
          ],
        ),
      ],
    );
  }
}
