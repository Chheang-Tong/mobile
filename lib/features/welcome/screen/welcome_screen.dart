import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../feature.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Container(color: Colors.teal.withOpacity(0.8)),
          ),
          Positioned(
            left: size.width * 0.2,
            top: size.height * -0.2,
            child: Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                // color: Colors.teal,
                image: DecorationImage(
                  image: AssetImage('assets/images/no_background.png'),
                ),
              ),
            ),
          ),
          Positioned(
            left: size.width * 0.2,
            right: size.width * 0.2,
            top: size.height * 0.6,
            bottom: size.height * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Welcome to", style: semiBoldExtraLarge),
                Text(
                  'Cavosy',
                  style: boldMegaLarge.copyWith(
                    fontSize: 36,
                    color: ColorResources.primaryColor,
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("Get Started"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
