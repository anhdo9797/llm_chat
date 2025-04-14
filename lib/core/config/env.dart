import 'package:flutter/foundation.dart';

class Env {
  static const apiKey = String.fromEnvironment('API_KEY', defaultValue: '');
  static const baseUrl = String.fromEnvironment('BASE_URL', defaultValue: '');

  // Validate env variables
  static bool isValid() {
    if (apiKey.isEmpty) {
      debugPrint('API_KEY is not set');
      return false;
    }
    if (baseUrl.isEmpty) {
      debugPrint('BASE_URL is not set');
      return false;
    }
    return true;
  }

  // Print env values for debugging
  static void debugPrintEnv() {
    if (kDebugMode) {
      print('Environment Variables:');
      print('BASE_URL: $baseUrl');
      print('API_KEY: ${apiKey.isEmpty ? 'NOT SET' : '****'}');
    }
  }
}
