import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();

    if (_isValidToken(token)) {
      await prefs.setString('token', token);
      debugPrint('✅ Token Saved Successfully');
    } else {
      debugPrint('❌ Invalid Token - Not Saved');
    }
  }

  static bool _isValidToken(String token) {
    try {
      // Decode and check token validity
      final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

      // Check Expiration
      final expirationTime =
          DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] * 1000);
      return expirationTime.isAfter(DateTime.now());
    } catch (e) {
      debugPrint('Token Validation Error: $e');
      return false;
    }
  }
}
