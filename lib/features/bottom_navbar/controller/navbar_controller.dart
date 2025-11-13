import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class NavbarController extends GetxController {
  int selectIndex = 0;
  List<Widget> screens = [
    Text('data1'),
    Text('data2'),
    Text('data3'),
    Text('data4'),
    Text('data5'),
  ];
  void changeIndex(int index) {
    selectIndex = index;
    update();
  }
}
