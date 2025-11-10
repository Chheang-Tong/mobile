import 'package:get/get.dart';
import '../../features/feature.dart';

class Routes {
  static const String splashScreen = "/splash_screen";
  static const String signin = "/sign_in";
  static const String signup = "/sign_up";
  static const String register = "/register";
  static const String bottomNavbar = "/bottom_navbar";
  static const String detailsScreen = "/details_screen";
  static const String home = "/home_screen";
  static const String menu = "/menu_screen";
  static const String cart = "/cart";
  static const String profile = "/profile";
  static const String favorite = "/favorite";
  static const String checkout = "/checkout";
  static const String payment = "/payment";
  static const String reviewOrder = "/review_order";
  static const String orderConfirmation = "/order_confirmation";
  List<GetPage> getPages = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
  ];
}
