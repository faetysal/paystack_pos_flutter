
import 'package:flutter/services.dart';

class PaystackPosFlutter {
  static const MethodChannel _channel = MethodChannel('paystack_pos_flutter');
  static Future<String> initPayment(int amount) async {
    final String result = await _channel.invokeMethod('initPayment', {
      'amount': amount
    });
    return result;
  }
}
