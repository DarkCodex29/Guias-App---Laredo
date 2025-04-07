import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
    await Future.wait([
      _storage.write(key: _tokenKey, value: token),
      _storage.write(key: _roleKey, value: role),
      _storage.write(key: _userIdKey, value: userId),
      _storage.write(key: _usernameKey, value: username),
    ]);
  }

  static Future<Map<String, String?>> getAuthData() async {
    final token = await _storage.read(key: _tokenKey);
    final role = await _storage.read(key: _roleKey);
    final userId = await _storage.read(key: _userIdKey);
    final username = await _storage.read(key: _usernameKey);

    return {
      'token': token,
      'role': role,
      'userId': userId,
      'username': username,
    };
  }

  static Future<void> clearAuthData() async {
    await Future.wait([
      _storage.delete(key: _tokenKey),
      _storage.delete(key: _roleKey),
      _storage.delete(key: _userIdKey),
      _storage.delete(key: _usernameKey),
    ]);
  }
}
