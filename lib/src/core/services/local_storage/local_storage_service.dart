abstract interface class LocalStorageService {
  Future<void> set<T extends Object?>(String key, T value);
  Future<void> remove(String key);
  Future<void> clear();
  Future<bool> exists(String key);
  Future<T?> get<T extends Object?>(String key);
}
