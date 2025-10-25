import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:cookie_jar/cookie_jar.dart';


class CookieHelper {
  static Future<CookieJar> createCookieJar({required bool persist}) async {
    if (!persist) return CookieJar();

    final dir = await getApplicationDocumentsDirectory();
    final cookiesPath = '${dir.path}/.cookies/';
    final folder = Directory(cookiesPath);
    if (!folder.existsSync()) folder.createSync(recursive: true);
    return PersistCookieJar(storage: FileStorage(cookiesPath));
  }

  static Future<void> clearAllCookies({required bool persist}) async {
    final jar = await createCookieJar(persist: persist);
    jar.deleteAll();
  }
}
