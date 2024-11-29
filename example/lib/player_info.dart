import 'package:bitmovin_player/bitmovin_player.dart';
import 'package:flutter/material.dart';

/// Maintains a table of player information that is updated dynamically based
/// on received player events. Player state only gets added to the table if at
/// least one event has been received for the corresponding state.
class PlayerInfo extends StatefulWidget {
  const PlayerInfo({super.key});

  @override
  State<StatefulWidget> createState() => PlayerInfoState();
}

class PlayerInfoState extends State<PlayerInfo> {
  final Map<String, dynamic> _data = {};

  Future<void> updatePlayerInfo(Player player, Event event) async {
    if (event is ReadyEvent) {
      final isLive = await player.isLive;
      _updatePlayerInfoForField('isLive', Future.value(isLive));

      final availableSubtitles = await player.availableSubtitles;
      final subtitleLanguages = availableSubtitles.map((element) {
        return element.label;
      }).toList();

      if (subtitleLanguages.isNotEmpty) {
        _updatePlayerInfoForField(
          'availableSubtitles',
          Future.value(
            subtitleLanguages.join(', '),
          ),
        );
      }

      if (isLive) {
        _updatePlayerInfoForField('maxTimeShift', player.maxTimeShift);
      } else {
        _updatePlayerInfoForField('duration', player.duration);
      }
    }
    if (event is PlayingEvent || event is PausedEvent) {
      _updatePlayerInfoForField('isPlaying', player.isPlaying);
    }
    if (event is TimeChangedEvent) {
      _updatePlayerInfoForField('currentTime', player.currentTime);
      final isLive = await player.isLive;
      if (isLive) {
        _updatePlayerInfoForField('timeShift', player.timeShift);
      }
    }
    if (event is SubtitleChangedEvent) {
      final subtitle = await player.subtitle;
      _updatePlayerInfoForField('subtitle', Future.value(subtitle.label));
    }
    if (event is CastAvailableEvent) {
      _updatePlayerInfoForField('isCastAvailable', player.isCastAvailable);
    }
    if (event is CastStartedEvent || event is CastStoppedEvent) {
      _updatePlayerInfoForField('isCasting', player.isCasting);
    }
  }

  void _updatePlayerInfoForField(String field, Future<dynamic> value) {
    value.then((dynamic value) {
      setState(() {
        _data[field] = value.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _data.length,
      itemBuilder: (context, index) {
        final key = _data.keys.elementAt(index);
        final value = _data[key];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(key),
              ),
              Expanded(
                flex: 3,
                child: Text(value.toString()),
              ),
            ],
          ),
        );
      },
    );
  }
}
