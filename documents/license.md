# Configure your License key

There are two ways to add your **License Key**
</br>
first will be via your **Platform Manifest** file `info.plist` for **iOS** and `AndroidManifet.xml` for **Android**,
</br>second is adding your **License Key** programmatically please see sample below.
</br>

## Option 1

For android

Open `/android/src/main/AndroidManifest.xml` and add the following code.

```xml
<application>
  <meta-data android:name="BITMOVIN_PLAYER_LICENSE_KEY" android:value="<YOUR LICENSE KEY>" />
</application>
```

</br>

---

For ios

Open `/ios/Runner/info.plist` and add the following code.

```xml
<dict>
  <key>BitmovinPlayerLicenseKey</key>
  <string>YOUR LICENSE KEY</string>
</dict>
```

---

## Options 2

Programmatically set your **License Key**

```dart
class PlayerScreen extends StatelessWidget {

  Player _player = Player();
  
  PlayerConfig _playerConfig = const PlayerConfig(
    key: "<YOUR LICENSE KEY>",
    playbackConfig: PlaybackConfig(
      isAutoplayEnabled: false,
    ),
  );

  build(BuildContent context) {
    return PlayerView(
      player: _player,
      playerConfig: _playerConfig,
      onViewCreated: _onViewCreated,
    );
  }
}
```
