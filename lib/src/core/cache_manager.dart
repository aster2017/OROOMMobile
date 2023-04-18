import 'package:get_storage/get_storage.dart';

mixin CacheManager {
  Future<bool> saveToken(Map<String, dynamic>? token) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.TOKEN.toString(), token!['token']);
    await box.write(CacheManagerKey.USER.toString(), token['subjectId']);
    return true;
  }

  String? getToken() {
    final box = GetStorage();
    return box.read(CacheManagerKey.TOKEN.toString());
  }

  String? getUserId() {
    final box = GetStorage();
    return box.read(CacheManagerKey.USER.toString());
  }

  Future<void> removeToken() async {
    final box = GetStorage();
    await box.remove(CacheManagerKey.TOKEN.toString());
    await box.remove(CacheManagerKey.USER.toString());
  }
}

enum CacheManagerKey { TOKEN, USER }
