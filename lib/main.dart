import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:matrimonial/blocs/auth_bloc/auth_state.dart';
import 'blocs/auth_bloc/auth_bloc.dart';
import 'services/api_service.dart';
import 'router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final apiService = ApiService();
  await apiService.init(persistCookies: true);

  final cookies = await apiService.cookieJar?.loadForRequest(Uri.parse(ApiService.baseUri));
  final bool isLoggedIn = cookies != null && cookies.isNotEmpty;

  final authBloc = AuthBloc(apiService: apiService);

  // Emit AuthSuccess if cookies exist
  if (isLoggedIn) {
    authBloc.emit(AuthSuccess());
  }

  final appRouter = AppRouter(apiService: apiService, authBloc: authBloc);

  runApp(MyApp(authBloc: authBloc, appRouter: appRouter));
}

class MyApp extends StatelessWidget {
  final AuthBloc authBloc;
  final AppRouter appRouter;

  const MyApp({super.key, required this.authBloc, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>.value(value: authBloc),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Maheshwari Matrimonial',
        theme: ThemeData(primarySwatch: Colors.red),
        routerConfig: appRouter.router,
      ),
    );
  }
}
