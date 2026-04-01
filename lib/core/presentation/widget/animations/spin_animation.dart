import 'package:flutter/material.dart';
import 'dart:math' as math;

class SpinAnimation extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final int delay;

  const SpinAnimation({
    super.key,
    required this.child,
    required this.duration,
    this.delay = 0,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 2 * math.pi),
      duration: duration,
      curve: Interval(
        delay / (delay + duration.inMilliseconds),
        1.0,
        curve: Curves.easeOut,
      ),
      builder: (_, value, child) => Transform.rotate(angle: value, child: child),
      child: child,
    );
  }
}
