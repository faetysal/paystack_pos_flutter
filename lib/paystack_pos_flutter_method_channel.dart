import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'paystack_pos_flutter_platform_interface.dart';

/// An implementation of [PaystackPosFlutterPlatform] that uses method channels.
class MethodChannelPaystackPosFlutter extends PaystackPosFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('paystack_pos_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
