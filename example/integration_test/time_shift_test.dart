import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'player_testing/player_testing.dart';

void main() {
  const kronehit = SourceConfig(
    url: 'https://bitcdn-kronehit.bitmovin.com/v2/hls/playlist.m3u8',
    type: SourceType.hls,
  );
  final logger = Logger();

  testWidgets('test framework example', (tester) async {
    await startPlayerTest(() async {
      await loadSourceConfig(kronehit);
      final TimeShiftEvent timeShiftEvent = await callPlayerAndExpectEvent(
        (player) {
          player.setTimeShift(-100);
        },
      );

      logger.d('timeShiftEvent: $timeShiftEvent');
      expect(timeShiftEvent.position, greaterThan(0));
      logger.d('we ready');
    });
    logger.d('finished');
  });
}
