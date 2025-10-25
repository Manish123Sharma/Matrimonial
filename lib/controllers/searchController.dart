import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import '../services/api_service.dart';

class SearchController extends GetxController {
  final ApiService apiService;
  SearchController({required this.apiService});

  var isLoading = false.obs;
  var results = <dynamic>[].obs;
  var error = ''.obs;

  Future<void> fetchResults({
    required int searchResultType,
    required String searchValue,
  }) async {
    try {
      isLoading.value = true;
      error.value = '';

      final dio.Response resp = await apiService.search(
        searchResultType: searchResultType,
        searchValue: searchValue,
      );

      if (resp.statusCode == 200) {
        results.value = resp.data is List ? resp.data : [resp.data];
      } else {
        error.value = 'Error ${resp.statusCode}: ${resp.statusMessage}';
      }
    } catch (e) {
      error.value = 'Failed: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
