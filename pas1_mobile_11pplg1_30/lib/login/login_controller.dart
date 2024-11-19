import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'apilogin_service.dart';

class ApiloginControllerr extends GetxController {
  final storage = GetStorage();
  final ApiloginServicee apiServicee = ApiloginServicee();
  var isLoading = false.obs;
  var loginStatus = ''.obs;
  var token = ''.obs;

  Future<void> loginUser(String username, String password) async {
    try {
      isLoading(true);

      final responseData = await apiServicee.login(username, password);

      if (responseData['status'] == true) {
        token.value = responseData['token'] ?? '';
        loginStatus.value = 'Login berhasil: ${responseData['message']}\nToken: ${token.value}';
        
        await storage.write('isLoggedIn', true);
        await storage.write('token', token.value);

        Get.snackbar(
          'Sukses',
          'Login berhasil!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAllNamed('/home');

      } else {
        loginStatus.value = 'Login gagal: ${responseData['message']}';
        Get.snackbar(
          'Error',
          responseData['message'] ?? 'Login gagal.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      loginStatus.value = 'Login gagal: $e';
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }
}
