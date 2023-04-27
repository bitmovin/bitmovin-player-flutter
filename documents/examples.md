# Examples

## Basic Playback

```dart
class PlayerScreen extends StatelessWidget {
  Player _player = Player();

  SourceConfig _sourceConfig = SourceConfig(
    url: Platform.isAndroid ? "https://bitmovin-a.akamaihd.net/content/MI201109210084_1/mpds/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.mpd" : 'https://bitmovin-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8',
    type: Platform.isAndroid ? SourceType.dash : SourceType.hls,
  ),

  void _onViewCreated(Player player) {
    player.loadWithSourceConfig(_sourceConfig);
  }

  @override
  void build(BuildContent context) {
    return SizeBox.from(
      size: Size.fromHeight(230),
      child: PlayerView(
        player: _player,
      ),
    );
  }
}
```

---

</br>

## Basic Controls (Manual)

```dart
typedef ControlAction = void Function()?;

class Controls extends StatelessWidget {
  const Controls({
    super.key,
    required this.onPlayPressed,
    required this.onPausePressed,
    required this.onLoadPressed,
    required this.onMutePressed,
    required this.onUnmutePressed,
  });

  final ControlAction onPlayPressed;
  final ControlAction onPausePressed;
  final ControlAction onLoadPressed;
  final ControlAction onMutePressed;
  final ControlAction onUnmutePressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton(
              onPressed: onPlayPressed,
              child: const Text('PLAY'),
            ),
            OutlinedButton(
              onPressed: onPausePressed,
              child: const Text('PAUSE'),
            ),
            OutlinedButton(
              onPressed: onLoadPressed,
              child: const Text('LOAD'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton(
              onPressed: onMutePressed,
              child: const Text('Mute'),
            ),
            OutlinedButton(
              onPressed: onUnmutePressed,
              child: const Text('Unmute'),
            ),
          ],
        ),
      ],
    );
  }
}


class PlayerScreen extends StatelessWidget {
  build(BuildContent context) {
    
    Player _player = Player();
    PlayerConfig _playerConfig = const PlayerConfig(
      playbackConfig: PlaybackConfig(
        isAutoplayEnabled: false,
      ),
    );
    SourceConfig _sourceConfig = SourceConfig(
      url: Platform.isAndroid ? "https://bitmovin-a.akamaihd.net/content/MI201109210084_1/mpds/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.mpd" : 'https://bitmovin-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8',
      type: Platform.isAndroid ? SourceType.dash : SourceType.hls,
    );

    void _onViewCreated(Player player) {
      player.loadWithSourceConfig(_sourceConfig);
    }

    return Column(
      children: [
        Controls(
          onPlayPressed: () => _player.play(),
          onPausePressed: () => _player.pause(),
          onLoadPressed: () => _player.loadWithSourceConfig(_sourceConfig),
          onMutePressed: () => _player.mute(),
          onUnmutePressed: () => _player.unmute(),
        ),
        PlayerView(
          player: _player,
          playerConfig: _playerConfig,
        ),
      ]
    )
  }
}
```

---

</br>

## Subcring to Events


```dart
class PlayerScreen extends StatelessWidget {
  Player _player = Player();

  SourceConfig _sourceConfig = SourceConfig(
    url: Platform.isAndroid ? "https://bitmovin-a.akamaihd.net/content/MI201109210084_1/mpds/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.mpd" : 'https://bitmovin-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8',
    type: Platform.isAndroid ? SourceType.dash : SourceType.hls,
  ),

  void listToEvent() {
    _player.onReady = (data) {
      print('Got on ready event');
    }
    _player.onTimeChanged = (data) {
      print('Got on time changed event');
    }
    _player.onPause = (data) {
      print('Got on pause event');
    }
    _player.onMute = (data) {
      print('Got on mute event');
    }
    _player.onUnmute = (data) {
      print('Got on unmute event');
    }
  }

  @override
  void initState() {
    listenToEvent();
    super.initState();
  }

  @override
  void build(BuildContent context) {
    return SizeBox.from(
      size: Size.fromHeight(230),
      child: PlayerView(
        player: _player,
      ),
    );
  }
}
```