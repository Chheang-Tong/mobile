import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeController extends GetxController {
  final _box = GetStorage('settings');
  final primary = const Color(0xFFE74C3D).obs;
  final fontScale = 1.0.obs;
  final fontFamily = 'Open Sans'.obs;
  final Rxn<Color> textColor = Rxn<Color>();

  final List<Color> palette = const [
    Color(0xFFE74C3C), // red
    Color(0xFF1E88E5), // blue
    Color(0xFF2ECC71), // green
    Color(0xFF8E44AD), // purple
    Color(0xFFF39C12), // orange
    Color(0xFF16A085), // teal
    Color(0xFFE91E63), // pink
    Color(0xFF3949AB), // indigo
    Color(0xFF00BCD4), // cyan
    Color(0xFFF1C40F), // yellow
    Color(0xFF7E57C2), // deep purple
  ];
  final Map<String, String> fontMap = const {
    'System Default': '',
    'Kantumruy Pro (KH)': 'Kantumruy Pro',
    'Noto Sans Khmer (KH)': 'Noto Sans Khmer',
    'Hanuman (KH)': 'Hanuman',
    'OpenSans': 'Open Sans',
    'Roboto': 'Roboto',
    'Poppins': 'Poppins',
    'Inter': 'Inter',
    'Nunito': 'Nunito',
    'Montserrat': 'Montserrat',
    'Lato': 'Lato',
  };
  @override
  void onInit() {
    primary.value = Color(_box.read('primary') ?? 0xFFE74C3D);
    fontScale.value = _box.read('fontScale') ?? 1.0;
    fontFamily.value = _box.read('fontFamily') ?? 'Open Sans';
    final tc = _box.read("textColor") as int?;
    textColor.value = (tc == null) ? null : Color(tc);
    super.onInit();
  }

  Future<void> saveTheme() async {
    await _box.write('primary', primary.value.value);
    await _box.write('fontScale', fontScale.value);
    await _box.write('fontFamily', fontFamily.value);
    final tc = textColor.value;
    if (tc != null) {
      await _box.write('textColor', tc.value);
    } else {
      await _box.remove('textColor');
    }
  }

  TextTheme applyFontFamily(TextTheme base) {
    final fam = fontFamily.value.trim();
    if (fam.isEmpty) return base;

    return GoogleFonts.getTextTheme(fam, base);
  }

  ThemeData applyToTheme(ThemeData base) {
    final text = applyFontFamily(base.textTheme);
    final Color? explicitTextColor = textColor.value;
    final tinted = (explicitTextColor == null)
        ? text
        : text.apply(
            bodyColor: explicitTextColor,
            displayColor: explicitTextColor,
          );
    final size = tinted.apply(fontSizeFactor: fontScale.value);
    final cs = base.colorScheme.copyWith(primary: primary.value);
    return base.copyWith(
      colorScheme: cs,
      textTheme: size,
      sliderTheme: base.sliderTheme.copyWith(
        thumbColor: cs.primary,
        activeTrackColor: cs.primary,
      ),
      appBarTheme: base.appBarTheme.copyWith(
        backgroundColor: cs.surface,
        foregroundColor: explicitTextColor ?? base.appBarTheme.foregroundColor,
        elevation: base.appBarTheme.elevation ?? 0,
      ),
    );
  }
}
