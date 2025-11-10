import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/common.dart';
import 'package:mobile/core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationController extends GetxController {
  final SharedPreferences sharedPreferences;
  LocalizationController({required this.sharedPreferences}) {
    loadCurrentLanguage();
  }

  Locale _locale = Locale(
    LocalStrings.appLanguages[0].languageCode,
    LocalStrings.appLanguages[0].countryCode,
  );

  bool _isLtr = true;
  final List<LanguageModel> _languages = LocalStrings.appLanguages;

  Locale get locale => _locale;
  bool get isLtr => _isLtr;
  List<LanguageModel> get languages => _languages;

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void setLanguage(Locale locale) {
    _locale = locale;
    _isLtr = !['ar', 'fa', 'he', 'ur', 'ps'].contains(_locale.languageCode);
    // update
    Get.updateLocale(_locale);
    // save
    // saveLanguage(_locale);
    _selectedIndex = _languages.indexWhere(
      (lang) =>
          lang.languageCode == _locale.languageCode &&
          lang.countryCode == _locale.countryCode,
    );
    if (_selectedIndex < 0) _selectedIndex = 0;
    update();
  }

  void loadCurrentLanguage() {
    final saveCode = sharedPreferences.getString(
      SharedPreferenceHelper.languageCode,
    );
    final saveCountry = sharedPreferences.getString(
      SharedPreferenceHelper.countryCode,
    );
    if (saveCode != null && saveCountry != null) {
      setLanguage(Locale(saveCode, saveCountry));
    } else {
      final device = Get.deviceLocale;
      final supported = _languages.any(
        (lang) =>
            lang.languageCode == device?.languageCode &&
            lang.countryCode == device?.countryCode,
      );
      _locale = supported
          ? Locale(device!.languageCode, device.countryCode)
          : Locale(
              LocalStrings.appLanguages[0].languageCode,
              LocalStrings.appLanguages[0].countryCode,
            );
    }
    _isLtr = !['ar', 'fa', 'he', 'ur', 'ps'].contains(_locale.languageCode);
    _selectedIndex = _languages.indexWhere(
      (lang) =>
          lang.languageCode == _locale.languageCode &&
          lang.countryCode == _locale.countryCode,
    );
    if (_selectedIndex < 0) _selectedIndex = 0;
    Get.updateLocale(_locale);
    update();
  }

  void saveLanguage(Locale locale) {
    sharedPreferences.setString(
      SharedPreferenceHelper.languageCode,
      locale.languageCode,
    );
    sharedPreferences.setString(
      SharedPreferenceHelper.countryCode,
      locale.countryCode ?? '',
    );
  }

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    final lang = _languages[index];
    setLanguage(Locale(lang.languageCode, lang.countryCode));
    update();
  }
}
