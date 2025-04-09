import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../log/logger.service.dart';

class StorageService {
  static const _storage = FlutterSecureStorage();
  static const _tokenKey = 'auth_token';
  static const _roleKey = 'auth_role';
  static const _userIdKey = 'auth_user_id';
  static const _usernameKey = 'auth_username';

  static Future<void> saveAuthData({
    required String token,
    required String role,
    required String userId,
    required String username,
  }) async {
    try {
      await _storage.write(key: _tokenKey, value: token);
      await _storage.write(key: _roleKey, value: role);
      await _storage.write(key: _userIdKey, value: userId);
      await _storage.write(key: _usernameKey, value: username);
    } catch (e) {
      LoggerService.error('Error saving auth data: $e');
    }
  }

  static Future<Map<String, String?>> getAuthData() async {
    String? token, role, userId, username;
    try {
      token = await _storage.read(key: _tokenKey);
      role = await _storage.read(key: _roleKey);
      userId = await _storage.read(key: _userIdKey);
      username = await _storage.read(key: _usernameKey);
    } catch (e) {
      LoggerService.error('Error getting auth data: $e');
      token = null;
      role = null;
      userId = null;
      username = null;
    }

    return {
      'token': token,
      'role': role,
      'userId': userId,
      'username': username,
    };
  }

  static Future<void> clearAuthData() async {
    try {
      await _storage.delete(key: _tokenKey);
      await _storage.delete(key: _roleKey);
      await _storage.delete(key: _userIdKey);
      await _storage.delete(key: _usernameKey);
    } catch (e) {
      LoggerService.error('Error clearing auth data: $e');
    }
  }
}
