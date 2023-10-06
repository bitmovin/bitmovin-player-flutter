import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:player_testing/player_testing.dart';

void main() {
  group('subtitle test', () {
    group('when loading a source with subtitles in the manifest', () {
      testWidgets('emits subtitle added events for each subtitle', (_) async {
        // No subtitle added event for the off-item on iOS
        final expectedCount = Platform.isAndroid ? 5 : 4;
        await startPlayerTest(() async {
          await callPlayerAndExpectEvents(
            (player) => player.loadSourceConfig(Sources.sintel),
            R(P(E.subtitleAdded), expectedCount),
          );
        });
      });
    });

    group('when selecting a subtitle', () {
      testWidgets('subtitle is selected', (_) async {
        await startPlayerTest(() async {
          String? subtitleToSelect;
          await loadSourceConfig(Sources.sintel);
          await callPlayer((player) async {
            final subtitles = await player.availableSubtitles;
            subtitleToSelect = subtitles?.last.id;
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
