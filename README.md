# paystack_pos_flutter

A Flutter plugin that communicates with the Paystack terminal app to make payments.

# Usage

```dart
  try {
    final result = await PaystackPosFlutter.initPayment(500000);
  } on PlatformException catch (err) {
    print("Err: ${err.message}");
  }
```