import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../ui/BlurContainer.dart';

class LoadingAnimation extends StatelessWidget {
  final VoidCallback onTap;

  const LoadingAnimation({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: GestureDetector(
        onTap: onTap,
        child: BlurContainer(
          child: Center(
            child: Lottie.asset("assets/animations/loading2.json", height: 130),
          ),
        ),
      ),
    );
  }
}
