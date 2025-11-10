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
    GetPage(name: signin, page: () => const SignInScreen()),
    GetPage(name: register, page: () => const RegisterScreen()),
    GetPage(name: bottomNavbar, page: () => const BottomNavBar()),
    GetPage(name: cart, page: () => CartScreen()),
    GetPage(name: home, page: () => HomeScreen()),
    GetPage(name: menu, page: () => MenuScreen()),
    GetPage(name: cart, page: () => CartScreen()),
    GetPage(name: profile, page: () => ProfileScreen()),
    GetPage(name: favorite, page: () => FavoriteScreen()),
    // GetPage(name: checkout, page: ()=> CheckoutScreen()),
    // GetPage(name: payment, page: ()=> PaymentScreen()),
    // GetPage(name: reviewOrder, page: ()=> ReviewOrderScreen()),
    // GetPage(name: orderConfirmation, page: ()=> OrderConfirmationScreen()),
  ];
}
