import 'dart:io';

import 'package:flutter/foundation.dart';

const bool isWeb = kIsWeb;
final bool isIOS = !isWeb && Platform.isIOS;
final bool isAndroid = !isWeb && Platform.isAndroid;
