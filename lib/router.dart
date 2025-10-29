import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrimonial/blocs/auth_bloc/auth_state.dart';
import 'blocs/auth_bloc/auth_bloc.dart';
import 'blocs/search_bloc/search_bloc.dart';
import 'screens/login_screen.dart';
import 'screens/search_view.dart';
import 'services/api_service.dart';

class AppRouter {
  final ApiService apiService;
  final AuthBloc authBloc;

  AppRouter({
    required this.apiService,
    required this.authBloc,
  });

  late final GoRouter router = GoRouter(
    initialLocation: '/',
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    routes: [
      GoRoute(
        path: '/',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/search',
        name: 'search',
        builder: (context, state) => BlocProvider(
          create: (_) => SearchBloc(apiService: apiService),
          child: const SearchScreen(),
        ),
      ),
    ],
    redirect: (context, state) {
      final authState = authBloc.state;
      final loggingIn = state.uri.path == '/';

      if (authState is AuthSuccess && loggingIn) return '/search';
      if (authState is! AuthSuccess && !loggingIn) return '/';
      return null;
    },
  );
}

/// Helper class to listen to BLoC streams for GoRouter refresh
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
