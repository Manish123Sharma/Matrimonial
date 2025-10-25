import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../services/api_service.dart';

class AuthController extends GetxController {
  final ApiService apiService = ApiService();

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var saveCookie = true.obs;

  /// login: returns true on success
  Future<bool> login({
    required String profileId,
    required String password,
    required int relation,
    required bool saveCookieFlag,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final resp = await apiService.login(
        profileId: profileId,
        password: password,
        relation: relation,
        saveCookie: saveCookieFlag,
      );
      // successful HTTP status
      if (resp.statusCode != null && resp.statusCode! >= 200 && resp.statusCode! < 300) {
        isLoading.value = false;
        return true;
      } else {
        errorMessage.value = 'Login failed. Server returned ${resp.statusCode}';
        isLoading.value = false;
        return false;
      }
    } on DioError catch (e) {
      final m = e.response?.data ?? e.message;
      errorMessage.value = 'Login failed: $m';
      isLoading.value = false;
      return false;
    } catch (e) {
      errorMessage.value = 'Unexpected error: $e';
      isLoading.value = false;
      return false;
    }
  }

  /// clear cookies and reset
  Future<void> logout({required bool persist}) async {
    await apiService.clearCookies(persist: persist);
  }
}
