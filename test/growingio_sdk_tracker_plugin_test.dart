import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growingio_sdk_tracker_plugin/growingio_sdk_tracker_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('growingio_sdk_tracker_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  // test('trackCustomEvent', () async {
  //   expect(await GrowingioSdkTrackerPlugin.trackCustomEvent, '42');
  // });
}
