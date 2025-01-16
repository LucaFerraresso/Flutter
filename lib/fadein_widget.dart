import 'package:flutter/material.dart';

class FadeInWidget extends StatelessWidget {
  final Widget child;

  const FadeInWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: 1.0,
      duration: const Duration(seconds: 1),
      child: child,
    );
  }
}
