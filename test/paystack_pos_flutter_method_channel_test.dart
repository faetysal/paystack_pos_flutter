import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paystack_pos_flutter/paystack_pos_flutter_method_channel.dart';

void main() {
  MethodChannelPaystackPosFlutter platform = MethodChannelPaystackPosFlutter();
  const MethodChannel channel = MethodChannel('paystack_pos_flutter');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
