
import 'paystack_pos_flutter_platform_interface.dart';

class PaystackPosFlutter {
  Future<String?> getPlatformVersion() {
    return PaystackPosFlutterPlatform.instance.getPlatformVersion();
  }
}
