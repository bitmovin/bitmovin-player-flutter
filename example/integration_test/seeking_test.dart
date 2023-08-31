import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:player_testing/player_testing.dart';

void main() {
  group('seeking test', () {
    group('when player is playing', () {
      group('and seeking to a new position', () {
        testWidgets('seeks to new position and continues playback', (_) async {
          await startPlayerTest(() async {
            await loadSourceConfig(Sources.artOfMotion);
            await callPlayerAndExpectEvent(
              (player) => player.play(),
              P(E.playing),
            );
            final events = await callPlayerAndExpectEvents(
              (player) => player.seek(20),
              S(
                [
                  P(E.seek),
                  P(E.seeked),
                  P(E.timeChanged),
                ],
              ),
            );
            final timeChangedEvent = events.last as TimeChangedEvent;
            expect(timeChangedEvent.time, closeTo(20, 1));
          });
        });
      });
    });
    group('when playback has not started yet', () {
      group('and seeking to a new position', () {
        testWidgets('seeks to new position without continuing playback',
            (_) async {
          await startPlayerTest(() async {
            await loadSourceConfig(Sources.artOfMotion);
            await callPlayerAndExpectEvents(
              (player) => player.seek(20),
              S(
                [
                  P(E.seek),
                  P(E.seeked),
                ],
              ),
            );
            await verifyPlayer((player) async {
              expect(await player.currentTime, closeTo(20, 1));
              expect(await player.isPlaying, false);
            });
          });
        });
      });
    });
  });
}
