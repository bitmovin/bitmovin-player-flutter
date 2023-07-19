import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:flutter_test/flutter_test.dart';
import 'player_testing/player_testing.dart';

void main() {
  const kronehit = SourceConfig(
    url: 'https://bitcdn-kronehit.bitmovin.com/v2/hls/playlist.m3u8',
    type: SourceType.hls,
  );

  testWidgets('test framework example', (tester) async {
    await startPlayerTest(() async {
      await loadSourceConfig(kronehit);
      final TimeShiftEvent timeShiftEvent = await callPlayerAndExpectEvent(
        (player) async {
          await player.setTimeShift(-100);
        },
      );
      expect(timeShiftEvent, isNotNull);

      final TimeShiftedEvent timeShiftedEvent = await expectEvent();
      expect(timeShiftedEvent, isNotNull);

      await callPlayer((player) async {
        final currentTimeShift = await player.timeShift;
        expect(currentTimeShift, closeTo(-100, 1));
      });
    });
  });
}
