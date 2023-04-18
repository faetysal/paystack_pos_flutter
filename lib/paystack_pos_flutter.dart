
import 'package:flutter/services.dart';

class PaystackPosFlutter {
  static const MethodChannel _channel = MethodChannel('demo_plugin');
  static Future<String> initPayment(int amount) async {
    final String result = await _channel.invokeMethod('initPayment', {
      'amount': amount
    });
    return result;
  }
}
