import 'dart:ui';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GlassContainer extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  double alpha;
  double raduis;
  double x;
  double y;
  double borderWidth;
  GlassContainer({
    super.key,
    required this.child,
    required this.width,
    required this.height,
    this.alpha = 0.2,
    this.raduis = 20.0,
    this.x = 10.0,
    this.y = 10.0,
    this.borderWidth = 1.5,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(raduis),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: x, sigmaY: y),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: alpha),
            borderRadius: BorderRadius.circular(raduis),
            border: Border.all(
              color: Colors.white.withValues(alpha: alpha),
              width: borderWidth,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
