import 'package:flutter_test/flutter_test.dart';
import 'package:player_testing/player_testing.dart';

void main() {
  group('subtitle test', () {
    group('when selecting a subtitle', () {
      testWidgets('subtitle is selected', (_) async {
        await startPlayerTest(() async {
          var subtitleToSelect = '';
          await loadSourceConfig(Sources.sintel);
          await callPlayer((player) async {
            final subtitles = await player.availableSubtitles;
            subtitleToSelect = subtitles.last.id;
          });

          final subtitleChanged = await callPlayerAndExpectEvent(
            (player) => player.setSubtitle(subtitleToSelect),
            P(E.subtitleChanged),
          );

          expect(
            subtitleChanged.newSubtitleTrack?.id,
            equals(subtitleToSelect),
          );
        });
      });
    });
  });
}
