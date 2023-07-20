// ignore_for_file: unused_local_variable

import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:flutter_test/flutter_test.dart';
import 'player_testing/player_testing.dart';

void main() {
  // TODO(mario): move to own file
  const kronehit = SourceConfig(
    url: 'https://bitcdn-kronehit.bitmovin.com/v2/hls/playlist.m3u8',
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
        E.timeShift,
      );
      await expectEvent(E.timeShifted);
      await callPlayer((player) async {
        final currentTimeShift = await player.timeShift;
        expect(currentTimeShift, closeTo(-100, 1));
      });
    });
  });
}
