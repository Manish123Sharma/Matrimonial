import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrimonial/blocs/auth_bloc/auth_bloc.dart';
import 'package:matrimonial/screens/login_screen.dart';
import 'package:matrimonial/screens/search_view.dart';
import 'package:matrimonial/services/api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize ApiService and cookie jar (persist: true) to check login state.
  final apiService = ApiService();
  await apiService.init(persistCookies: true);

  // Check cookies for base domain
  final cookies = await apiService.cookieJar?.loadForRequest(
    Uri.parse(ApiService.baseUri),
  );

  final bool isLoggedIn = cookies != null && cookies.isNotEmpty;

  runApp(MyApp(isLoggedIn: isLoggedIn, apiService: apiService));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final ApiService apiService;
  const MyApp({super.key, required this.isLoggedIn, required this.apiService});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Provide AuthBloc app-wide
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(apiService: apiService),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Maheshwari Matrimonial',
        theme: ThemeData(primarySwatch: Colors.red),
        home: isLoggedIn ? const SearchScreen() : const LoginScreen(),
      ),
    );
  }
}
