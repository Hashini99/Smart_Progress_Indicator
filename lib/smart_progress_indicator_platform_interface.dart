import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'smart_progress_indicator_method_channel.dart';

abstract class SmartProgressIndicatorPlatform extends PlatformInterface {
  /// Constructs a SmartProgressIndicatorPlatform.
  SmartProgressIndicatorPlatform() : super(token: _token);

  static final Object _token = Object();

  static SmartProgressIndicatorPlatform _instance = MethodChannelSmartProgressIndicator();

  /// The default instance of [SmartProgressIndicatorPlatform] to use.
  ///
  /// Defaults to [MethodChannelSmartProgressIndicator].
  static SmartProgressIndicatorPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SmartProgressIndicatorPlatform] when
  /// they register themselves.
  static set instance(SmartProgressIndicatorPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
