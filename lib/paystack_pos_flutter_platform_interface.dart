import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'paystack_pos_flutter_method_channel.dart';

abstract class PaystackPosFlutterPlatform extends PlatformInterface {
  /// Constructs a PaystackPosFlutterPlatform.
  PaystackPosFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static PaystackPosFlutterPlatform _instance = MethodChannelPaystackPosFlutter();

  /// The default instance of [PaystackPosFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelPaystackPosFlutter].
  static PaystackPosFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PaystackPosFlutterPlatform] when
  /// they register themselves.
  static set instance(PaystackPosFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
