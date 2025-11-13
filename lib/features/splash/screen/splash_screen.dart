import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../feature.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    final controller = Get.put(SplashController(pref: Get.find()));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.checkandGo();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<SplashController>(
      builder: (ctr) {
        return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              // Positioned.fill(
              //   child: Container(color: Colors.teal.withOpacity(0.8)),
              // ),
              Positioned(
                left: size.width * 0.2,
                top: size.height * -0.2,
                child: Container(
                  width: size.width,
                  height: size.height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/no_background.png'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
