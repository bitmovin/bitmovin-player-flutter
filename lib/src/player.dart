import 'package:bitmovin_sdk/src/channel_manager.dart';
import 'package:bitmovin_sdk/src/configs/player_config.dart';
import 'package:bitmovin_sdk/src/configs/source_config.dart';
import 'package:bitmovin_sdk/src/interfaces/player_event_interface.dart';
import 'package:bitmovin_sdk/src/models/source.dart';
import 'package:bitmovin_sdk/src/player_event_listener.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';

class Player
    with WidgetsBindingObserver, PlayerEventListener
    implements PlayerInterface {
  Player([
    this.playerConfig = const PlayerConfig(),
  ]) {
    _uuid = hashCode.toString();
    WidgetsBinding.instance.addObserver(this);

    _channelManager.method
        .invokeMethod<bool>(
      'CREATE_PLAYER',
      Map<String, dynamic>.from({
        'id': _uuid,
        'playerConfig': playerConfig?.toJson(),
      }),
    )
        .then((value) {
      if (value != null && value == true) {
        _methodChannel = MethodChannel('player-$_uuid');
        _playerViewEventChannel = EventChannel('player-events-$_uuid');
        _playerViewEventChannel.receiveBroadcastStream().listen((e) {
          logger.e(e);
          onEvent(e);
        });
      }
    });
  }

  final PlayerConfig? playerConfig;
  final Logger logger = Logger(printer: PrettyPrinter(noBoxingByDefault: true));
  late String _uuid;
  final ChannelManager _channelManager = ChannelManager();
  late MethodChannel _methodChannel;
  late EventChannel _playerViewEventChannel;

  String get id => _uuid;
  String get channelName => 'player-$_uuid';

  Future<void> dispose() async {
    return _invokeMethod('destroy');
  }

  Map<String, dynamic> _buildPayload([dynamic data]) {
    return Map<String, dynamic>.from({
      'id': id,
      'data': data,
    });
  }

  Future<T?> _invokeMethod<T>(
    String methodName, [
    dynamic data,
  ]) =>
      _methodChannel.invokeMethod<T>(methodName, _buildPayload(data));

  @override
  Future<void> loadWithSourceConfig(
    SourceConfig sourceConfig,
  ) async =>
      _invokeMethod('loadWithSourceConfig', sourceConfig.toJson());

  @override
  Future<void> loadWithSource(Source source) async {
    return _invokeMethod<void>('loadWithSource', source.toJson());
  }

  @override
  Future<void> play() async => _invokeMethod<void>('play');

  @override
  Future<void> mute() async => _invokeMethod<void>('mute');

  @override
  Future<void> pause() async => _invokeMethod<void>('pause');

  @override
  Future<void> unmute() async => _invokeMethod<void>('unmute');

  @override
  Future<void> seek(double time) async => _invokeMethod<void>('seek', time);

  @override
  Future<double> currentTime() async {
    return await _invokeMethod<double>('current_time') ?? 0.0;
  }

  @override
  Future<double> duration() async {
    return await _invokeMethod<double>('duration') ?? 0.0;
  }

  @override
  void didChangeAccessibilityFeatures() {}
}
