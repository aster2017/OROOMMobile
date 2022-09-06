import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orb/src/features/app/views/app.dart';
import '../authentication_manager.dart';
import '../repository/api_repository.dart';

class AuthController extends GetxController {
  late final AuthenticationRepository _authenticationRepository;
  late final AuthenticationManager _authManager;
  final isLoading = false.obs;
  final refreshLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    _authenticationRepository = AuthenticationRepository();
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
      final response = await _authenticationRepository.obtainToken(
          username: username, password: password);
      print(response);
      if (response != null && response['token'] != null) {
        _authManager.login(response);
        isLoading.value = false;
        Get.offAll(AppPage());
      } else {
        isLoading.value = false;
        throw "Invalid User Credential";
      }
    } catch (e) {
      print(e.toString());
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

  Future<void> registerUser(String username, String password) async {
    try {
      isLoading.value = true;
      final response = await _authenticationRepository.registerUser(
          username: username, password: password);
      if (response != null) {
        loginUser(username, password);
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
}
