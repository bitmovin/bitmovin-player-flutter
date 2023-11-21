import 'package:flutter/material.dart';

typedef ControlAction = void Function()?;

class Controls extends StatelessWidget {
  const Controls({
    required this.onPlayPressed,
    required this.onPausePressed,
    required this.onLoadPressed,
    required this.onMutePressed,
    required this.onUnmutePressed,
    required this.onSkipForwardPressed,
    required this.onSkipBackwardPressed,
    super.key,
  });

  final ControlAction onPlayPressed;
  final ControlAction onPausePressed;
  final ControlAction onLoadPressed;
  final ControlAction onMutePressed;
  final ControlAction onUnmutePressed;
  final ControlAction onSkipForwardPressed;
  final ControlAction onSkipBackwardPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Wrap(
                  spacing: 8,
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
                      onPressed: onMutePressed,
                      child: const Text('Mute'),
                    ),
                    OutlinedButton(
                      onPressed: onUnmutePressed,
                      child: const Text('Unmute'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                child: Wrap(
                  spacing: 8,
                  children: [
                    OutlinedButton(
                      onPressed: onLoadPressed,
                      child: const Text('Reload'),
                    ),
                    OutlinedButton(
                      onPressed: onSkipBackwardPressed,
                      child: const Text('Skip Back'),
                    ),
                    OutlinedButton(
                      onPressed: onSkipForwardPressed,
                      child: const Text('Skip Forward'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
