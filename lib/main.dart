import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimonial/controllers/authController.dart';
import 'package:matrimonial/screens/search_view.dart';
import 'package:matrimonial/services/api_service.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize ApiService
  final apiService = Get.put(ApiService());
  await apiService.init(persistCookies: true);

  // Check if cookies exist (user logged in)
  final cookies = await apiService.cookieJar?.loadForRequest(
    Uri.parse('https://test.maheshwari.org'),
  );

  final bool isLoggedIn = cookies != null && cookies.isNotEmpty;

  Get.put(AuthController());

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maheshwari Matrimonial',
      theme: ThemeData(primarySwatch: Colors.red),
      home: isLoggedIn ? const SearchScreen() : const LoginScreen(),
    ),
  );
}
