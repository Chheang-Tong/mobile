import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/core.dart';

class SplashController extends GetxController {
  final SharedPreferences pref;
  SplashController({required this.pref});

  checkandGo() async {
    bool isSeen = pref.getBool(SharedPreferenceHelper.welcomeKey) ?? false;
    update();
    data(isSeen);
  }

  data(bool isSeen) {
    if (isSeen == false) {
      Future.delayed(Duration(seconds: 1), () {
        Get.offAllNamed(Routes.welcomeScreen);
      });
    } else {
      Future.delayed(Duration(seconds: 1), () {
        Get.offAllNamed(Routes.bottomNavbar);
      });
    }
  }
}
