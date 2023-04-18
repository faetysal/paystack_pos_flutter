import 'package:flutter_test/flutter_test.dart';
import 'package:paystack_pos_flutter/paystack_pos_flutter_platform_interface.dart';
import 'package:paystack_pos_flutter/paystack_pos_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPaystackPosFlutterPlatform
    with MockPlatformInterfaceMixin
    implements PaystackPosFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final PaystackPosFlutterPlatform initialPlatform = PaystackPosFlutterPlatform.instance;

  test('$MethodChannelPaystackPosFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPaystackPosFlutter>());
  });
}
