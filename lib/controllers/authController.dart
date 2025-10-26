import 'dart:convert';
import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens/home_screen.dart'; // <-- Import your HomeScreen here

class AuthController extends GetxController {
  final profileIdController = TextEditingController();
  final passwordController = TextEditingController();

  var selectedRelation = ''.obs;
  var rememberMe = false.obs;
  var isLoading = false.obs;

  final Dio dio = Dio();
  final cookieJar = CookieJar();

  @override
  void onInit() {
    dio.interceptors.add(CookieManager(cookieJar));
    super.onInit();
  }

  bool validateFields() {
    if (profileIdController.text.trim().isEmpty) {
      showError("Please enter Profile ID");
      return false;
    }
    if (passwordController.text.trim().isEmpty) {
      showError("Please enter Password");
      return false;
    }
    if (selectedRelation.value.isEmpty) {
      showError("Please select Relation");
      return false;
    }
    return true;
  }

  void showError(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade700,
      colorText: Colors.white,
    );
  }

  void showSuccess(String message) {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  Future<void> loginUser() async {
    if (!validateFields()) return;

    isLoading.value = true;

    try {
      const apiUrl = 'https://test.maheshwari.org/api/user/authenticate';
      final profileId = profileIdController.text.trim();
      final password = passwordController.text.trim();
      final relation = selectedRelation.value;
      final saveCookie = rememberMe.value.toString();

      final token =
          base64Encode(utf8.encode('$profileId:$password:$relation:$saveCookie'));
      final headers = {'Authorization': 'Basic $token'};

      final response = await dio.get(
        apiUrl,
        options: Options(headers: headers),
      );

      final data = response.data;

      if (data != null && data['Authenticated'] == true) {
        // Save cookies received from API
        final cookies = response.headers.map['set-cookie'];
        if (cookies != null) {
          final uri = Uri.parse('https://test.maheshwari.org');
          final cookieList = cookies.map((c) => Cookie.fromSetCookieValue(c)).toList();
          await cookieJar.saveFromResponse(uri, cookieList);
        }

        showSuccess("Login Successful! Welcome to Maheshwari Matrimonial.");

        // Navigate to HomeScreen and remove login from stack
        Get.offAll(() => const HomeScreen());
      } else {
        final message = data?['Message'] ?? 'Invalid credentials.';
        showError(message);
      }
    } on DioException catch (e) {
      final msg = e.response?.data['Message'] ??
          'Something went wrong. Please try again.';
      showError(msg);
    } catch (e) {
      showError('Unexpected error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
