# Bitmovin Flutter SDK (Alpha) 

Official Flutter bindings for Bitmovin's mobile Player SDKs, currently in Alpha.

> As the library is under active development, this means certain features from our native SDKs are not yet exposed 
> through these Flutter bindings. See [Feature Support](#feature-support) for an overview of the supported features.
>
> Not seeing the features you’re looking for?
> We are accepting community pull requests to this open-source project, so please feel free to contribute 
> or let us know in [our community](https://community.bitmovin.com/c/requests/14) what features we should work on next.

## Platform Support 

* iOS/iPadOS 14.0+
* Android API Level 16+

## Feature Support

Features of the native mobile Player SDKs are progressively being implemented in this Flutter library. The table below summarizes the current state of the main Player SDK features.

| Feature | Android | iOS, iPadOS |
| :--- | :--- | :--- |
| Supported media formats | DASH, HLS, Progressive | HLS, Progressive |
| Playback of DRM-protected media | :white_check_mark: (Widevine) | :white_check_mark: (FairPlay) |
| Bitmovin Web UI | :white_check_mark: | :white_check_mark:|
| Subtitles & Captions | :hourglass: Planned for Q3, 2023 | :hourglass: Planned for Q3, 2023 |
| Support for Apple TV / Android TV / Fire TV | :hourglass: Planned for Q3, 2023 | :hourglass: Planned for Q3, 2023 |
| [Bitmovin Analytics](https://developer.bitmovin.com/playback/docs/enabling-bitmovin-analytics) | :hourglass: Planned for Q3, 2023 | :hourglass: Planned for Q3, 2023 |
| Full-screen support | :hourglass: Planned for Q3, 2023 | :hourglass: Planned for Q3, 2023 |
| Casting | :hourglass: Planned for Q3, 2023 | :hourglass: Planned for Q3, 2023 |
| AirPlay | :hourglass: Planned for Q3, 2023 | :hourglass: Planned for Q3, 2023 |
| Picture-in-Picture | :x: Not available | :x: Not available |
| Background Playback | :x: Not available | :x: Not available |
| Advertising (Google IMA CSAI) | :x: Not available | :x: Not available |
| Offline Playback | :x: Not available | :x: Not available |
| Playlist API | :x: Not available | :x: Not available |

> **Note:**
> Some of the unavailable features mentioned above already work to some degree. 
> 
> For instance, it is possible to use the AirPlay button from the Bitmovin Player UI to play back content on an AirPlay 
> receiver. However, AirPlay related player events, API calls and configuration options are not yet fully exposed to the 
> Dart side. 
> 
> The same holds for subtitles and captions. They are available to be selected from the UI and they are also rendered, 
> however, the full API surface related to subtitles is not yet available from Dart code.

# Get Started
If you want to play around with the code, implement a new feature or just run the example apps, follow along with this section. If you just want to use the player in your own flutter app, you can skip this and follow the instructions in the [Installation](#installation) section.

- [Install](https://docs.flutter.dev/get-started/install) `flutter` on your machine
- Install `Node.js` and `npm` on your machine
- Run `npm ci` in the root of the cloned repository
  - This will setup [husky](https://github.com/typicode/husky) powered pre-commit git hooks

## For iOS Development
- Install `Mint` on your machine (e.g. `brew install mint`)
- Run `mint bootstrap` in the root of the cloned repository to install packages from `Mintfile`

To build the example project with your own developer account, create the config file 
`example/iOS/Flutter/Developer.xcconfig`. Enter your development team like this:

```
DEVELOPMENT_TEAM = YOUR_TEAM_ID
```

## For Android Development
- Install `ktlint` (e.g. `brew install ktlint`)

## Example App
To be able to use the example app, follow these steps:
1. Create a file named `.env` in the project root
1. Put your private bitmovin player license key inside the newly created `.env` file as `BITMOVIN_PLAYER_LICENSE_KEY=YOUR_LICENSE_KEY`, replacing `YOUR_LICENSE_KEY` with your license key which can be obtained from [Bitmovin's Dashboard](bitmovin.com/dashboard)
1. In the [Dashboard](bitmovin.com/dashboard), add `com.bitmovin.player.flutter.example` as an allowed package name
1. Run `flutter pub run build_runner build --delete-conflicting-outputs` in the project root which should generate the missing `example/lib/env/env.g.dart` file
1. Start the example app by running the command `flutter run` inside the `example/` directory


# Installation
The `bitmovin_player` package is still under development and not yet published to [pub.dev](https://pub.dev). 
However, it can used as a local dependency in any Flutter app. To do so, add the `bitmovin_player` dependency with the
correct relative path to your app's `pubspec.yaml` as show exemplary below:

```yml
dependencies:
  bitmovin_player:
    path: ./../bitmovin-player-flutter
```

## Android Specific Steps
Add Bitmovin's maven repo to `android/build.gradle`:
```gradle
maven {
    url 'https://artifacts.bitmovin.com/artifactory/public-releases'
}
```

## iOS Specific Steps
Add Bitmovin's Cocoapod repo as a source on top of `ios/Podfile`:
```ruby
source 'https://github.com/bitmovin/cocoapod-specs.git'
```

If you see any errors during `pod install` after adding the source from above, try deleting `Podfile.lock` and do a 
fresh `pod install`. At this point, `pod install` might fail due to the incorrect minimum deployment target being set 
for the `Runner` project. Set the deployment target and minimum deployment version to at least iOS 14 in `Runner` 
project to fix this.

```ruby
platform :ios, '14.0'
source 'https://github.com/bitmovin/cocoapod-specs.git'

## The rest of your Podfile ##
```

## Providing a Bitmovin Player License Key
When a `Player` instance is created, it will need a Bitmovin Player license key which has to be set in the `PlayerConfig` that is used to create the `Player`. 

To obtain a bitmovin player license key, please visit [Bitmovin's Dashboard](bitmovin.com/dashboard). Furthermore, make sure to associate your iOS and Android app bundle identifiers with your license key. More information on that can be found [here](https://bitmovin.com/docs/player/getting-started/ios#step-3-configure-your-player-license).

Now, you can provide your license key via the `PlayerConfig`:
```dart
final player = Player(
  config: const PlayerConfig(
    key: 'YOUR_LICENSE_KEY',
  ),
);
```

# Setting up the playback configuration

If needed, the default player behavior can be configured through the `PlayerConfig`.

```dart
class PlayerScreen extends StatelessWidget {
  final _player = Player(
    const PlayerConfig(
      playbackConfig: PlaybackConfig(
        isAutoplayEnabled: true,
        isMuted: true,
      ),
    ),
  );

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

</br>

# Basic Playback

Bare minimum code needed to start using `Player` with `PlayerView`.

```dart
class PlayerScreen extends StatelessWidget {
  Player _player = Player();

  SourceConfig _sourceConfig = SourceConfig(
    url: Platform.isAndroid ? "https://bitmovin-a.akamaihd.net/content/MI201109210084_1/mpds/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.mpd" : 'https://bitmovin-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8',
    type: Platform.isAndroid ? SourceType.dash : SourceType.hls,
  ),

  void _onViewCreated(Player player) {
    _player.loadWithSourceConfig(_sourceConfig);
  }

  @override
  void build(BuildContent context) {
    return SizeBox.from(
      size: Size.fromHeight(230),
      child: PlayerView(
        player: _player,
        onViewCreated: _onViewCreated,
      ),
    );
  }
}
```

</br>

# Basic playback (Audio Only)

Bare minimum code needed to start using `Player` without the `PlayerView`

`control.dart`
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
```

`playerscreen.dart`
```dart
class PlayerScreen extends StatelessWidget {
  build(BuildContent context) {
    
    Player _player = Player();
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
        ),
      ]
    )
  }
}
```

---

</br>

# Subscribing to Events

The following example demonstrates how to subscribe to an `Event` of the `Player` and `Source`

```dart
class PlayerScreen extends StatelessWidget {
  Player _player = Player();

  SourceConfig _sourceConfig = SourceConfig(
    url: Platform.isAndroid ? "https://bitmovin-a.akamaihd.net/content/MI201109210084_1/mpds/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.mpd" : 'https://bitmovin-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8',
    type: Platform.isAndroid ? SourceType.dash : SourceType.hls,
  ),

  void listToEvent() {
    _player.onReady = (ReadyEvent data) {
      print('Got on ready event');
    }
    _player.onTimeChanged = (TimeChangedEvent data) {
      print('Got on time changed event');
    }
    _player.onPause = (PausedEventdata) {
      print('Got on pause event');
    }
    _player.onMute = (MutedEvent data) {
      print('Got on mute event');
    }
    _player.onUnmute = (UnmutedEvent data) {
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
