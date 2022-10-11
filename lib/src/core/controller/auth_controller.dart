import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orb/src/core/model/user.dart';
import 'package:orb/src/features/app/views/app.dart';
import '../authentication_manager.dart';
import '../cache_manager.dart';
import '../repository/api_repository.dart';

class AuthController extends GetxController with CacheManager {
  late final ApiRepository _apiRepository;
  late final AuthenticationManager _authManager;
  final isLoading = false.obs;
  final refreshLoading = false.obs;
  final userId = ''.obs;
  final Rx<UserDetail?> user = Rx<UserDetail?>(null);
  @override
  void onInit() {
    super.onInit();
    _apiRepository = ApiRepository();
    _authManager = Get.find();
  }

  void logoutUser() {
    isLoading.value = false;

    _authManager.logOut();
  }

  void deleteUser() {
    isLoading.value = false;

    _authManager.logOut(delete: true);
  }

  Future<void> loginUser(String username, String password) async {
    try {
      isLoading.value = true;
      final response = await _apiRepository.obtainToken(
          username: username, password: password);
      if (response != null && response['token'] != null) {
        await _authManager.login(response);
        userId.value = response['id'];
        await getUser();
        isLoading.value = false;
        Get.offAll(AppPage());
      } else {
        isLoading.value = false;
        throw "Invalid User Credential";
      }
    } catch (e) {
      isLoading.value = false;
      Get.showSnackbar(GetSnackBar(
        title: "Error!",
        message: e.toString(),
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        margin: EdgeInsets.all(10),
        borderRadius: 20,
      ));
    }
  }

  Future<void> getUser() async {
    try {
      final token = getUserId();
      final res = await _apiRepository.getUser(userId: token!);
      print("res $res");
      user.value = UserDetail.fromJson(res!);
    } catch (e) {
      print(e.toString());
      Get.showSnackbar(GetSnackBar(
        title: "Error!",
        message: e.toString(),
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        margin: EdgeInsets.all(10),
        borderRadius: 20,
      ));
    }
  }

  Future<void> sendOtp() async {
    try {
      final res = await _apiRepository.sendOtp(email: user.value!.email!);
    } catch (e) {
      print(e.toString());
      Get.showSnackbar(GetSnackBar(
        title: "Error!",
        message: e.toString(),
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        margin: EdgeInsets.all(10),
        borderRadius: 20,
      ));
    }
  }

  Future<void> verifyOtp(String code) async {
    try {
      final res = await _apiRepository.verifyOtp(
          email: user.value!.email!, token: code);
    } catch (e) {
      print(e.toString());
      Get.showSnackbar(GetSnackBar(
        title: "Error!",
        message: e.toString(),
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        margin: EdgeInsets.all(10),
        borderRadius: 20,
      ));
    }
  }

  Future<void> registerUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNo,
  }) async {
    try {
      isLoading.value = true;
      final response = await _apiRepository.registerUser(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        phoneNo: phoneNo,
      );
      await loginUser(email, password);
    } catch (e) {
      isLoading.value = false;
      Get.showSnackbar(GetSnackBar(
        title: "Error!",
        message: e.toString(),
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        margin: EdgeInsets.all(10),
        borderRadius: 20,
      ));
    }
  }
}
