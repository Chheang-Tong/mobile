import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/core/core.dart';

import '../../feature.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final NavbarController navbarController = Get.put(NavbarController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<NavbarController>(
      builder: (controller) {
        return Scaffold(
          extendBody: true,
          body: controller.screens[controller.selectIndex],
          bottomNavigationBar: Container(
            height: 80,
            width: size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(38),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                btn(
                  onTap: () {},
                  title: "Home",
                  icon: Icons.home,
                  index: 0,
                  controller: controller,
                ),
                btn(
                  onTap: () {},
                  title: "Menu",
                  icon: Icons.library_books_sharp,
                  index: 1,
                  controller: controller,
                ),
                btn(
                  onTap: () {},
                  title: "Favorite",
                  icon: Icons.favorite,
                  index: 2,
                  controller: controller,
                ),
                btn(
                  onTap: () {},
                  title: "Profile",
                  icon: Icons.person,
                  index: 3,
                  controller: controller,
                ),
                btn(
                  onTap: () {},
                  title: "Settings",
                  icon: Icons.settings,
                  index: 4,
                  controller: controller,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  btn({
    required VoidCallback? onTap,
    required String title,
    required IconData? icon,
    required int index,
    required NavbarController controller,
  }) {
    final bool isSelected = controller.selectIndex == index;
    return GestureDetector(
      onTap: () => controller.changeIndex(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected
                ? ColorResources.primaryColor
                : ColorResources.dark45,
            size: 30,
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(
              color: isSelected
                  ? ColorResources.primaryColor
                  : ColorResources.dark45,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
