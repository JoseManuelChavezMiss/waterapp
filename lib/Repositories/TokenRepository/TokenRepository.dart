import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class TokenRepository {
  String? getDecodedToken(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) {
        throw Exception('Invalid token');
      }

      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      final payloadDecoded = utf8.decode(base64Url.decode(normalized));
      final values = json.decode(payloadDecoded);

      final roles = values['roles'];
      if (roles != null && roles is List && roles.isNotEmpty) {
        return roles[0];
      } else {
        throw Exception('Roles not found in token');
      }
    } catch (e) {
      print('Error decoding token: $e');
      return null;
    }
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    return token != null && token.isNotEmpty;
  }
}