import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import '../core/constants.dart';
import '../utils/cookie_helper.dart';

class ApiService {
  late Dio dio;
  CookieJar? cookieJar;

  ApiService();

  /// initialize dio with cookieJar (persist or memory)
  Future<void> init({required bool persistCookies}) async {
    cookieJar = await CookieHelper.createCookieJar(persist: persistCookies);
    dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl))
      ..interceptors.add(CookieManager(cookieJar!));
  }

  /// login GET request as required. Returns response data on success.
  Future<Response> login({
    required String profileId,
    required String password,
    required int relation,
    required bool saveCookie,
  }) async {
    await init(persistCookies: saveCookie);
    final authString = '$profileId:$password:$relation:${saveCookie ? 'true' : 'false'}';
    final basic = 'Basic ' + base64Encode(utf8.encode(authString));
    final options = Options(headers: {'Authorization': basic});
    // GET to /api/user/authenticate
    final resp = await dio.get(ApiConstants.authEndpoint, options: options);
    return resp;
  }

  /// search POST using existing cookieJar (must be already initialized by login)
  Future<Response> search({required int searchResultType, required String searchValue}) async {
  if (cookieJar == null) {
    throw Exception('CookieJar not initialized. Please login first.');
  }
  final payload = {
    'SearchResultType': searchResultType,
    'SearchValue': searchValue,
  };
  final resp = await dio.post(ApiConstants.searchEndpoint, data: payload);
  return resp;
}


  Future<void> clearCookies({required bool persist}) async {
    if (cookieJar != null) {
      cookieJar!.deleteAll();
    } else {
      await CookieHelper.clearAllCookies(persist: persist);
    }
  }
}
