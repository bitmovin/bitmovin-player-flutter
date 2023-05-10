# Get Started
- Install `flutter` on your machine if you haven't already
- Install `Node.js` and `npm` on your machine if you haven't already
- Enter the repo and run `npm ci`

For iOS development
- Install `Mint` on your machine if you haven't already (`brew install mint`)

# Bitmovin Flutter SDK

Flutter plugin for bitmovin.

Supported Platform
- :white_check_mark: Android
- :white_check_mark: iOS

</br>

# Installation

Run the following command to install **bitmovin_sdk**

`flutter pub add bitmovin_sdk`

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
  <meta-data android:name="BITMOVIN_PLAYER_LICENSE_KEY" android:value="<YOUR LICENSE KEY>" />
</application>
```

</br>

## iOS

Open `/ios/Runner/info.plist` and add the following code.

```xml
<dict>
  <key>BitmovinPlayerLicenseKey</key>
  <string>YOUR LICENSE KEY</string>
</dict>
```

</br>

## Via code

You can add your license key via the `PlayerConfig` object

example
```dart
final player = Player(PlayerConfig(licenseKey: '<LICENSE_KEY>'))
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