import 'dart:ui';
import 'package:flutter/material.dart';

class BlurContainer extends StatelessWidget {
  final Widget child;
  final double sigmaX;
  final double sigmaY;
  final Color overlayColor;

  const BlurContainer({
    Key? key,
    required this.child,
    this.sigmaX = 2,
    this.sigmaY = 2,
    this.overlayColor = Colors.white38,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
      child: Container(
        color: overlayColor, // Semi-transparent color overlay
        child: child,
      ),
    );
  }
}
