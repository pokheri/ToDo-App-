import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  ///  this class is used to manage  the storage token safely and stored with encription

  static final _storag = FlutterSecureStorage();

  static Future<void> saveAccessToken(String token) async {
    await _storag.write(key: 'access_token', value: token);
  }

  static Future<void> saveRefreshToken(String token) async {
    await _storag.write(key: 'refresh_token', value: token);
  }

  static Future<String?> getAccessToken() async {
    return await _storag.read(key: 'access_token');
  }

  /// to access the refresh token
  static Future<String?> getRefreshToken() async {
    return await _storag.read(key: 'refresh_token');
  }

  /// method to delete  the access and refresh token from the storage
  static Future<void> clearToken() async {
    await _storag.delete(key: 'access_token');
    await _storag.delete(key: 'refresh_token');
  }
}
