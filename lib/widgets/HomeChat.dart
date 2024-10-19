import 'package:flutter/material.dart';
import 'package:voice_text_ai/widgets/BuildUI.dart'; // Import your BuildUI widget

class HomeChat extends StatelessWidget {
  const HomeChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Opacity(
            opacity: 0.3,
            child: Image.asset(
              'assets/images/bg.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        const BuildUI(), // Use BuildUI widget here
      ],
    );
  }
}
