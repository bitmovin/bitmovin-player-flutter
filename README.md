# Bitmovin Flutter SDK (Alpha) 

Official Flutter bindings for Bitmovin's mobile Player SDKs, currently in Alpha.

> As the library is under active development, this means certain features from our native SDKs are not yet exposed through these Flutter bindings.
> See [Feature Support](#feature-support) for an overview of the supported features.
>
> Not seeing the features you’re looking for?
> We are accepting community pull requests to this open-source project so please feel free to contribute.
> or let us know in [our community](https://community.bitmovin.com/c/requests/14) what features we should work on next.

## Platform Support 

- :white_check_mark: Android
- :white_check_mark: iOS

## Feature Support

Features of the native mobile Player SDKs are progressively being implemented in this Flutter library. The table below summarizes the current state of the main Player SDK features.

| Feature                          | State                                     |
| -------------------------------- | ----------------------------------------- |
| Playback of DRM-protected assets | :white_check_mark: Available since v0.0.1 |
| Subtitles & Captions             | :x: Not available                         |
| Advertising                      | :x: Not available                         |
| Analytics                        | :x: Not available                         |
| Playlist API                     | :x: Not available                         |
| Casting                          | :x: Not available                         |
| Offline Playback                 | :x: Not available                         |


# Get Started
- Install `flutter` on your machine if you haven't already
- Install `Node.js` and `npm` on your machine if you haven't already
- Enter the repo and run `npm ci`

## For iOS development
- Install `Mint` on your machine if you haven't already (`brew install mint`)

## For Android development
- Install `ktlint` (`brew install ktlint`)

## Example App
To be able to use the example app, follow these steps:
1. Create a file named `.env` in the project root
1. Put your private bitmovin player license key inside the newly created `.env` file as `BITMOVIN_PLAYER_LICENSE_KEY=YOUR_LICENSE_KEY`, replacing `YOUR_LICENSE_KEY` with your license key which can be obtained from [Bitmovin's Dashboard](bitmovin.com/dashboard)
1. In the [Dashboard](bitmovin.com/dashboard), add `com.bitmovin.player.flutter.example` as an allowed package name
1. Run `flutter pub run build_runner build --delete-conflicting-outputs` in the project root which should generate the missing `example/lib/env/env.g.dart` file
1. Start the example app by running the command `flutter run` inside the `example/` directory


# Installation

Run the following command to install **bitmovin_player**

`flutter pub add bitmovin_player`

</br>

## Android
No extra steps needed.

</br>

## iOS
Add this source on top of your `Podfile`
```terminal
source https://github.com/bitmovin/cocoapod-specs.git
```

</br>

eg:
```script

# Uncomment this line to define a global platform for your project
platform :ios, '14.0'
source 'https://github.com/bitmovin/cocoapod-specs.git'

... The rest of your PodFile ...

target 'Runner' do
  # use_frameworks!
  use_modular_headers!

  pod 'BitmovinPlayer', '3.37.1'
  
  flutter_install_all_ios_pods File.dirname(File.realpath(__FILE__))
end
```

</br>

# Setting up the Player License Key

There are two ways to add your **License Key**

first will be via your **Platform Manifest** file `info.plist` for **iOS** and `AndroidManifet.xml` for **Android**.

second is programmatically.

## Android

Open `/android/src/main/AndroidManifest.xml` and add the following code.

```xml
<application>
  <meta-data android:name="BITMOVIN_PLAYER_LICENSE_KEY" android:value="YOUR_LICENSE_KEY" />
</application>
```

</br>

## iOS

Open `/ios/Runner/info.plist` and add the following code.

```xml
<dict>
  <key>BitmovinPlayerLicenseKey</key>
  <string>YOUR_LICENSE_KEY</string>
</dict>
```

</br>

## Via code

You can add your license key via the `PlayerConfig` object

example
```dart
final player = Player(PlayerConfig(licenseKey: 'YOUR_LICENSE_KEY'))
```

</br>

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

# Publishing package to **pub.dev**

First, sign in to pub.dev with your Google Account.

Before publishing, make sure to review the `pubspec.yaml`, `README.md`, and `CHANGELOG.md` files.

Update the `version` property on the `pubspec.yaml` if needed.

Next, run the publish command in **dry-run** mode to see if everything passes analysis:

```terminal
flutter pub publish --dry-run
```

If there is any error solve it else we can publish it to pub.dev.
But be sure that you are ready because publishing is forever.
we can’t remove the package from there. So if you are ready, run following command:

```terminal
flutter pub publish
```

For authentication, one link will be provided, just open in browser and select your google account.
Wait for uploading.
And it’s Done, Hurrah! You have created your own Futter Package.

You can search for your package on the ***https://pub.dev*** site after some time, It will take a few minutes.

For more information please refer to https://dart.dev/tools/pub/publishing
