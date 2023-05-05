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