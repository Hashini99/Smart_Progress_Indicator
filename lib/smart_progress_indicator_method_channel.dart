import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'smart_progress_indicator_platform_interface.dart';

/// An implementation of [SmartProgressIndicatorPlatform] that uses method channels.
class MethodChannelSmartProgressIndicator extends SmartProgressIndicatorPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('smart_progress_indicator');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
