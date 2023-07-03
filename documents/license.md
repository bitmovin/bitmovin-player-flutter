# Setting up the Player License Key

There are two ways to add your **License Key**

first will be via your **Platform Manifest** file `info.plist` for **iOS** and `AndroidManifet.xml` for **Android**.

## For android

Open `/android/src/main/AndroidManifest.xml` and add the following code.

```xml
<application>
  <meta-data android:name="BITMOVIN_PLAYER_LICENSE_KEY" android:value="YOUR_LICENSE_KEY" />
</application>
```

---

</br>

## For ios

Open `/ios/Runner/info.plist` and add the following code.

```xml
<dict>
  <key>BitmovinPlayerLicenseKey</key>
  <string>YOUR_LICENSE_KEY</string>
</dict>
```

---

## Adding license key programmatically

You can add your license key via the `PlayerConfig` object

example
```dart
final player = Player(PlayerConfig(licenseKey: 'YOUR_LICENSE_KEY'))
```
