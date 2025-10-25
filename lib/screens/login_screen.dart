import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimonial/api_routes.dart';
import 'package:matrimonial/controllers/authController.dart';
import 'package:matrimonial/controllers/searchController.dart' as my;

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final AuthController _authC = Get.put(AuthController());
  final _profileCtrl = TextEditingController(text: '1');
  final _passwordCtrl = TextEditingController(text: '1234567');
  int _relation = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Maheshwari — Login')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _profileCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Profile ID'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordCtrl,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Relation:'),
                const SizedBox(width: 12),
                DropdownButton<int>(
                  value: _relation,
                  items: const [
                    DropdownMenuItem(value: 1, child: Text('Self')),
                    DropdownMenuItem(value: 2, child: Text('Parents')),
                    DropdownMenuItem(value: 3, child: Text('Siblings')),
                    DropdownMenuItem(value: 4, child: Text('Other')),
                  ],
                  onChanged: (v) {
                    if (v != null) setState(() => _relation = v);
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            Obx(() {
              return CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                value: _authC.saveCookie.value,
                onChanged: (v) => _authC.saveCookie.value = v ?? true,
                title: const Text('Save Cookie'),
              );
            }),
            const SizedBox(height: 12),
            Obx(() {
              return _authC.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        final profileId = _profileCtrl.text.trim();
                        final password = _passwordCtrl.text;
                        final saveCookieFlag = _authC.saveCookie.value;
                        final ok = await _authC.login(
                          profileId: profileId,
                          password: password,
                          relation: _relation,
                          saveCookieFlag: saveCookieFlag,
                        );
                        if (ok) {
                          // ✅ Corrected: use alias to avoid conflict with Flutter's built-in SearchController
                          final searchC = Get.put(
                            my.SearchController(apiService: _authC.apiService),
                          );
                          await searchC.fetchResults(
                            searchResultType: 1,
                            searchValue: '1',
                          );
                          Get.offNamed(Routes.search);
                        } else {
                          Get.snackbar(
                            'Login failed',
                            _authC.errorMessage.value,
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      },
                      child: const Text('Login'),
                    );
            }),
            const SizedBox(height: 12),
            Obx(
              () => _authC.errorMessage.value.isEmpty
                  ? const SizedBox.shrink()
                  : Text(
                      _authC.errorMessage.value,
                      style: const TextStyle(color: Colors.red),
                    ),
            ),
            const SizedBox(height: 20),
            // const Text(
            //   'Test creds: ProfileId: 1, Password: 1234567, Relation: 1/2/3/4',
            // ),
          ],
        ),
      ),
    );
  }
}
