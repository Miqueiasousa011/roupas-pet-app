import 'local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class SharedPreferencesService implements LocalStorageService {
  static Future<SharedPreferences> _getInstance() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<void> clear() async {
    final prefs = await _getInstance();
    await prefs.clear();
  }

  @override
  Future<bool> exists(String key) async {
    final prefs = await _getInstance();
    return prefs.containsKey(key);
  }

  @override
  Future<T?> get<T extends Object?>(String key) async {
    if (!await exists(key)) return null;
    final prefs = await _getInstance();

    final value = prefs.get(key);

    if (value is! T) return null;

    return value;
  }

  @override
  Future<void> remove(String key) async {
    final prefs = await _getInstance();
    await prefs.remove(key);
  }

  @override
  Future<void> set<T extends Object?>(String key, T value) async {
    final prefs = await _getInstance();

    switch (T) {
      case const (String):
        {
          await prefs.setString(key, value as String);
          break;
        }
      case const (int):
        {
          await prefs.setInt(key, value as int);
          break;
        }
      case const (double):
        {
          await prefs.setDouble(key, value as double);
          break;
        }
      case const (bool):
        {
          await prefs.setBool(key, value as bool);
          break;
        }
      case const (List<String>):
        {
          await prefs.setStringList(key, value as List<String>);
          break;
        }
      default:
        {
          throw UnsupportedError('Unsupported type $T!');
        }
    }
  }
}
