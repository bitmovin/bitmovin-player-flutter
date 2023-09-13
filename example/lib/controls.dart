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
  EdgeInsets get insetFirst => const EdgeInsets.only(left: 10, right: 5);
  EdgeInsets get insetMiddle => const EdgeInsets.only(left: 5, right: 5);
  EdgeInsets get insetLast => const EdgeInsets.only(left: 5, right: 10);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: insetFirst,
              child: OutlinedButton(
                onPressed: onPlayPressed,
                child: const Text('Play'),
              ),
            ),
            Container(
              margin: insetMiddle,
              child: OutlinedButton(
                onPressed: onPausePressed,
                child: const Text('Pause'),
              ),
            ),
            Container(
              margin: insetMiddle,
              child: OutlinedButton(
                onPressed: onMutePressed,
                child: const Text('Mute'),
              ),
            ),
            Container(
              margin: insetLast,
              child: OutlinedButton(
                onPressed: onUnmutePressed,
                child: const Text('Unmute'),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              margin: insetFirst,
              child: OutlinedButton(
                onPressed: onLoadPressed,
                child: const Text('Reload'),
              ),
            ),
            Container(
              margin: insetMiddle,
              child: OutlinedButton(
                onPressed: onSkipBackwardPressed,
                child: const Text('Skip Back'),
              ),
            ),
            Container(
              margin: insetLast,
              child: OutlinedButton(
                onPressed: onSkipForwardPressed,
                child: const Text('Skip Forward'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
