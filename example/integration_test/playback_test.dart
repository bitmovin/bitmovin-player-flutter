import 'package:flutter_test/flutter_test.dart';
import 'package:player_testing/player_testing.dart';

void main() {
  group('playback test', () {
    group('when a source is loaded', () {
      group('and play is called', () {
        testWidgets('starts playback', (_) async {
          await startPlayerTest(() async {
            await loadSourceConfig(Sources.artOfMotion);
            await callPlayerAndExpectEvents(
              (player) => player.play(),
              S([
                P(E.play),
                P(E.playing),
                P(E.timeChanged),
              ]),
            );
          });
        });
      });
    });
    group('when player is playing', () {
      group('and pause is called', () {
        testWidgets('pauses', (_) async {
          await startPlayerTest(() async {
            await loadSourceConfig(Sources.artOfMotion);
            await playFor(1);
            await callPlayerAndExpectEvent(
              (player) => player.pause(),
              P(E.paused),
            );
          });
        });
      });
    });
  });
}
