import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthSecureStorage {
  AuthSecureStorage(this._storage);

  final FlutterSecureStorage _storage;

  static const _tokenKey = 'auth_token';
  static const _emailKey = 'auth_email';
  static const _onboardingKey = 'onboarding_completed';

  Future<bool> isOnboardingCompleted() async {
    final value = await _storage.read(key: _onboardingKey);
    return value == 'true';
  }

  Future<void> completeOnboarding() {
    return _storage.write(key: _onboardingKey, value: 'true');
  }

  Future<bool> isAuthenticated() async {
    final token = await _storage.read(key: _tokenKey);
    return token != null && token.isNotEmpty;
  }

  Future<String?> getEmail() {
    return _storage.read(key: _emailKey);
  }

  Future<void> saveSession({required String email}) async {
    await _storage.write(
      key: _tokenKey,
      value: 'demo-token-${DateTime.now().millisecondsSinceEpoch}',
    );
    await _storage.write(key: _emailKey, value: email);
  }

  Future<void> logout() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _emailKey);
  }
}
