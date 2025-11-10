import 'package:get/get.dart';
import 'package:mobile/core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/common.dart';
// ignore: unused_import
import '../../features/feature.dart';

Future<Map<String, Map<String, String>>> init() async {
  final prefs = await SharedPreferences.getInstance();
  Get
    ..put<SharedPreferences>(prefs, permanent: true)
    ..lazyPut<LocalizationController>(
      () => LocalizationController(sharedPreferences: Get.find()),
    )
    ..lazyPut<BiometricService>(() => BiometricService(), fenix: true)
    ..lazyPut<ThemeController>(() => ThemeController(), fenix: true);

  Map<String, Map<String, String>> language = {};
  language['km_KH'] = {'': ''};
  return language;
}
