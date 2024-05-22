import 'package:flutter/material.dart';

class AnimatedSwitcherWidget extends StatelessWidget {
  const AnimatedSwitcherWidget({super.key, required this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      reverseDuration: const Duration(milliseconds: 250),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      child: child,
    );
  }
}
