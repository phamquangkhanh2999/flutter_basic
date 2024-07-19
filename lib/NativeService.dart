import 'package:flutter/services.dart';

class NativeService {
  static const platform = MethodChannel('com.example/native');

  Future<String> fetchData() async {
    try {
      final String result = await platform.invokeMethod('fetchData');
      return result;
    } catch (e) {
      throw 'Failed to fetch data: $e';
    }
  }
}
