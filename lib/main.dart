import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimonial/api_routes.dart';
import 'package:matrimonial/screens/login_screen.dart';
import 'package:matrimonial/screens/search_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Maheshwari Matrimonial (Test)',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepPurple),
      initialRoute: Routes.login,
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: Routes.login, page: () => const LoginView()),
        GetPage(name: Routes.search, page: () => const SearchView()),
      ],
    );
  }
}
