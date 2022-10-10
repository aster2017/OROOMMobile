import 'package:get/get.dart';
import 'package:orb/src/core/cache_manager.dart';

class AuthenticationManager extends GetxController with CacheManager {
  final isLogged = false.obs;
  final isRegister = true.obs;

  void logOut({bool delete = false}) async {
    isLogged.value = false;
    removeToken();
  }

  void changeRegister(bool change) {
    isRegister.value = change;
  }

  void login(Map<String, dynamic> token) async {
    isLogged.value = true;
    await saveToken(token);
  }

  Future<bool> checkLoginStatus() async {
    final token = getToken();
    if (token != null) {
      isLogged.value = true;
      return true;
    }
    return false;
  }
}
