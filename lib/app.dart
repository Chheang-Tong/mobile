import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import '/common/common.dart';
import 'core/core.dart';
import 'core/core.dart' as services show init;

void main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      final languages = await services.init();
      await FlutterLocalization.instance.ensureInitialized();
      await Future.wait([
        initializeDateFormatting('km'),
        initializeDateFormatting('en'),
      ]);
      if (Env.shouldShowApiLog) {
        debugPrint(Env.name);
      }
      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.presentError(details);
        debugPrint("FlutterError: ${details.exceptionAsString()}");
      };
      runApp(MyApp(languages: languages));
    },
    (error, stackTrace) {
      debugPrint('Caught error in zone: $error');
      debugPrintStack(stackTrace: stackTrace);
      debugPrint(Env.name);
    },
  );
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;
  const MyApp({super.key, required this.languages});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(
      builder: (locales) {
        final themeController = Get.find<ThemeController>();
        return Obx(() {
          final baseTheme = ThemeData(
            useMaterial3: true,
            colorSchemeSeed: themeController.primary.value,
          );
          final baseText = baseTheme.textTheme;
          final family = themeController.fontFamily.value.trim();
          final withFamily = family.isEmpty
              ? baseText
              : GoogleFonts.getTextTheme(family, baseText);
          final withColor = (themeController.textColor.value == null)
              ? withFamily
              : withFamily.apply(
                  bodyColor: themeController.textColor.value,
                  displayColor: themeController.textColor.value,
                );
          final theme = baseTheme.copyWith(
            textTheme: withColor,
            appBarTheme: baseTheme.appBarTheme.copyWith(
              foregroundColor:
                  themeController.textColor.value ??
                  baseTheme.appBarTheme.foregroundColor,
            ),
            sliderTheme: baseTheme.sliderTheme.copyWith(
              thumbColor: themeController.primary.value,
              activeTrackColor: themeController.primary.value,
            ),
          );
          return GetMaterialApp(
            title: Env.appName,
            debugShowCheckedModeBanner: Env.isDebugging,
            initialRoute: Routes.splashScreen,
            getPages: Routes().getPages,
            translations: Messages(languages: languages),
            supportedLocales: const [Locale('en', 'US'), Locale('km', 'KH')],
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            fallbackLocale: Locale(
              locales.locale.languageCode,
              locales.locale.countryCode,
            ),
            theme: theme,
            builder: (context, child) {
              final mq = MediaQuery.of(context);
              return Obx(
                () => MediaQuery(
                  data: mq.copyWith(
                    textScaler: TextScaler.linear(
                      Get.find<ThemeController>().fontScale.value,
                    ),
                  ),
                  child: child ?? SizedBox.shrink(),
                ),
              );
            },
          );
        });
      },
    );
  }
}
