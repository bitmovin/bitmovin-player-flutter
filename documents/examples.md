# Examples

``` dart
class PlayerScreen extends StatelessWidget {
  build(BuildContent context) {
    return Player(
      url: 'https://bitmovin-a.akamaihd.net/content/MI201109210084_1/mpds/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.mpd',
      playerConfig: PlayerConfig(
        licenseKey: 'dad76518-41bb-4105-9712-153c98ba337b'
      ),
    );
  }
}
```