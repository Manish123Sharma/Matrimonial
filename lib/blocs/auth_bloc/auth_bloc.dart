import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import '../../services/api_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../../constants/constants.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ApiService apiService;
  final Dio _dio = Dio();
  final CookieJar _cookieJar = CookieJar();

  AuthBloc({required this.apiService}) : super(AuthInitial()) {
    _dio.interceptors.add(CookieManager(_cookieJar));

    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());

      try {
        final response = await _dio.get(
          '${ApiService.baseUri}${ApiConstants.authEndpoint}',
          options: Options(
            headers: {
              'Authorization': 'Basic ${base64Encode(utf8.encode("${event.profileId}:${event.password}:${event.relation}:${event.rememberMe}"))}'
            },
          ),
        );

        final data = response.data;
        if (data != null && data['Authenticated'] == true) {
          // Save cookies returned by server into cookieJar used by ApiService
          final cookies = response.headers.map['set-cookie'];
          if (cookies != null) {
            final uri = Uri.parse(ApiService.baseUri);
            final cookieList = cookies.map((c) => Cookie.fromSetCookieValue(c)).toList();
            await _cookieJar.saveFromResponse(uri, cookieList);
          }

          // initialize apiService with persist option so its cookieJar matches saved cookies
          await apiService.init(persistCookies: event.rememberMe);

          emit(AuthSuccess());
        } else {
          final message = data?['Message'] ?? 'Invalid credentials.';
          emit(AuthFailure(message));
        }
      } on DioException catch (e) {
        final msg = e.response?.data?['Message'] ?? e.response?.data ?? e.message;
        emit(AuthFailure(msg.toString()));
      } catch (e) {
        emit(AuthFailure('Unexpected error: $e'));
      }
    });

    on<LogoutRequested>((event, emit) async {
      await apiService.clearCookies(persist: false);
      emit(AuthInitial());
    });
  }
}
