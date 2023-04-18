import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:paystack_pos_flutter/paystack_pos_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _result = "...";

  @override
  void initState() {
    super.initState();
  }

  Future<void> _initPayment() async {
    String result;

    try {
      result = await PaystackPosFlutter.initPayment(75000);
    } on PlatformException catch (err) {
      result = err.message!;
    }

    if (!mounted) return;

    setState(() {
      _result = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('PaystackPOS Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text('Make Payment'),
                onPressed: () {
                  _initPayment();
                },
              ),
              Text(_result)
            ],
          )
        ),
      ),
    );
  }
}
