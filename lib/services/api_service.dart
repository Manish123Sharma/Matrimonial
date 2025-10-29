import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import '../constants/constants.dart';
import '../utils/cookie_helper.dart';

class ApiService {
  static const String baseUri = ApiConstants.baseUrl;
  late Dio dio;
  CookieJar? cookieJar;

  ApiService();

  /// Initialize Dio with CookieJar (persistent or in-memory)
  Future<void> init({required bool persistCookies}) async {
    cookieJar = await CookieHelper.createCookieJar(persist: persistCookies);

    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 15),
        responseType: ResponseType.json,
      ),
    )
      ..interceptors.add(CookieManager(cookieJar!))
      ..interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (obj) => print(obj),
      ));
  }

  /// LOGIN GET request
  Future<Response> login({
    required String profileId,
    required String password,
    required int relation,
    required bool saveCookie,
  }) async {
    try {
      await init(persistCookies: saveCookie);

      final authString =
          '$profileId:$password:$relation:${saveCookie ? 'true' : 'false'}';
      final basic = 'Basic ${base64Encode(utf8.encode(authString))}';

      final options = Options(headers: {'Authorization': basic});

      final resp = await dio.get(ApiConstants.authEndpoint, options: options);
      return resp;
    } on DioException catch (e) {
      final message = e.response?.data ?? e.message;
      throw Exception('Login failed: $message');
    } catch (e) {
      throw Exception('Unexpected login error: $e');
    }
  }

  /// SEARCH POST request (requires cookieJar initialised)
  Future<Response> search({
    required int searchResultType,
    required String searchValue,
  }) async {
    if (cookieJar == null) {
      throw Exception('CookieJar not initialized. Please login first.');
    }

    final payload = {
      'SearchResultType': searchResultType,
      'SearchValue': searchValue,
    };

    try {
      final resp = await dio.post(ApiConstants.searchEndpoint, data: payload);
      return resp;
    } on DioException catch (e) {
      final message = e.response?.data ?? e.message;
      throw Exception('Search failed: $message');
    } catch (e) {
      throw Exception('Unexpected search error: $e');
    }
  }

  /// Clear cookies (for logout/reset)
  Future<void> clearCookies({required bool persist}) async {
    if (cookieJar != null) {
      await cookieJar!.deleteAll();
    } else {
      await CookieHelper.clearAllCookies(persist: persist);
    }
  }
}
