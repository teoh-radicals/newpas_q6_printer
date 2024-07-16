import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:newpas_q6_printer/newpas_q6_printer_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelNewpasQ6Printer platform = MethodChannelNewpasQ6Printer();
  const MethodChannel channel = MethodChannel('newpas_q6_printer');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    // expect(await platform.getPlatformVersion(), '42');
  });
}
