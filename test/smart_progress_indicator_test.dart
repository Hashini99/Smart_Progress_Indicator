import 'package:flutter_test/flutter_test.dart';
import 'package:smart_progress_indicator/smart_progress_indicator.dart';
import 'package:smart_progress_indicator/smart_progress_indicator_platform_interface.dart';
import 'package:smart_progress_indicator/smart_progress_indicator_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSmartProgressIndicatorPlatform
    with MockPlatformInterfaceMixin
    implements SmartProgressIndicatorPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final SmartProgressIndicatorPlatform initialPlatform = SmartProgressIndicatorPlatform.instance;

  test('$MethodChannelSmartProgressIndicator is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSmartProgressIndicator>());
  });

  test('getPlatformVersion', () async {
    SmartProgressIndicator smartProgressIndicatorPlugin = SmartProgressIndicator();
    MockSmartProgressIndicatorPlatform fakePlatform = MockSmartProgressIndicatorPlatform();
    SmartProgressIndicatorPlatform.instance = fakePlatform;

    expect(await smartProgressIndicatorPlugin.getPlatformVersion(), '42');
  });
}
