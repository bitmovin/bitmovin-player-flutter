// ignore_for_file: unused_local_variable

import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:player_testing/player_testing.dart';

void main() {
  // TODO(mario): move to own file
  const kronehit = SourceConfig(
    url: 'https://bitcdn-kronehit.bitmovin.com/v2/hls/playlist.m3u8',
    type: SourceType.hls,
  );
  const artOfMotion = SourceConfig(
    url:
        'https://bitmovin-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8',
    type: SourceType.hls,
  );

  // TODO(mario): fix test name and introduce nested structure with more tests
  // TODO(mario): introduce multi event expectations and expect timeShift and
  // timeShifted in one go
  testWidgets('test framework example', (tester) async {
    await startPlayerTest(() async {
      await loadSourceConfig(kronehit);
      await callPlayerAndExpectEvent(
        (player) async {
          await player.setTimeShift(-100);
        },
        P(E.timeShift),
      );
      await expectEvent(P(E.timeShifted));
      await callPlayer((player) async {
        final currentTimeShift = await player.timeShift;
        expect(currentTimeShift, closeTo(-100, 1));
      });
    });
  });

  testWidgets('plain event expectation test', (tester) async {
    await startPlayerTest(() async {
      await loadSourceConfig(artOfMotion);
      await callPlayer((player) => player.play());
      await expectEvent(P(E.timeChanged));
    });
  });

  testWidgets('filtered event expectation test', (tester) async {
    await startPlayerTest(() async {
      await loadSourceConfig(artOfMotion);
      await callPlayer((player) => player.play());
      await expectEvent(F(E.timeChanged, (event) {
        return event.time > 5;
      }));
    });
  });

  testWidgets('event sequence expectation test', (tester) async {
    await startPlayerTest(() async {
      await loadSourceConfig(artOfMotion);
      await callPlayer((player) => player.play());
      await expectEvents(S([
        P(E.playing),
        P(E.timeChanged),
      ]));
    });
  });

  testWidgets('event bag expectation test', (tester) async {
    await startPlayerTest(() async {
      await loadSourceConfig(artOfMotion);
      await callPlayer((player) => player.play());
      await expectEvents(B([
        P(E.timeChanged),
        P(E.playing),
      ]));
    });
  });

  testWidgets('repeated event expectation test', (tester) async {
    await startPlayerTest(() async {
      await loadSourceConfig(artOfMotion);
      await callPlayer((player) => player.play());
      await expectEvents(R(P(E.timeChanged), 5));
    });
  });
}
