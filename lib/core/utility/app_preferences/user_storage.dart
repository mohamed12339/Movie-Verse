import 'package:shared_preferences/shared_preferences.dart';

class UserStorage {
  static const _nameKey = 'name';
  static const _emailKey = 'email';
  static const _avatarKey = 'avatarId';

  static Future<void> saveUser({
    required String name,
    required String email,
    required int avatarId,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_nameKey, name);
    await prefs.setString(_emailKey, email);
    await prefs.setInt(_avatarKey, avatarId);
  }

  static Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString(_nameKey);
    final email = prefs.getString(_emailKey);
    final avatarId = prefs.getInt(_avatarKey);

    if (name != null && email != null && avatarId != null) {
      return {
        "name": name,
        "email": email,
        "avatarId": avatarId,
      };
    }
    return null;
  }

  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_nameKey);
    await prefs.remove(_emailKey);
    await prefs.remove(_avatarKey);
  }
}