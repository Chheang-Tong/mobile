import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService extends GetxService {
  SharedPreferences sharedPreferences;
  ApiService({required this.sharedPreferences});
}
