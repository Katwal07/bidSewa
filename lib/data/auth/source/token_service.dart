part of 'auth_api_imports.dart';

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

  static Future<String?> getId() async{
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString("userId");
    return userId;
  }

  static Future<void> saveUserId(String userId) async{
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('userId', userId);
    debugPrint("UserId: $userId");
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
