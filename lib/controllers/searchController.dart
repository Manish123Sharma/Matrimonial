import 'package:get/get.dart';
import '../services/api_service.dart';

class SearchUserController extends GetxController {
  final ApiService apiService = Get.find<ApiService>();

  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxList<dynamic> results = <dynamic>[].obs;

  /// Fetches results and appends them (instead of overwriting)
  Future<void> fetchSearchResults({required int searchResultType, required String searchValue}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await apiService.search(
        searchResultType: searchResultType,
        searchValue: searchValue,
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data != null && data['Results'] != null) {
          // Append results instead of replacing
          results.addAll(data['Results']);
        } else {
          errorMessage.value = 'No results found.';
        }
      } else {
        errorMessage.value = 'Server error: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'Error fetching results: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
