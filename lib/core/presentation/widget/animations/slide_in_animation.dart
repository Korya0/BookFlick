import 'package:flutter/material.dart';

class SlideInAnimation extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final int delay;
  final Curve curve;

  const SlideInAnimation({
    super.key,
    required this.child,
    required this.duration,
    this.delay = 0,
    this.curve = Curves.easeOut,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Offset>(
      tween: Tween<Offset>(begin: const Offset(-1.0, 0), end: Offset.zero),
      duration: duration,
      curve: Interval(
        delay / (delay + duration.inMilliseconds),
        1.0,
        curve: curve,
      ),
      child: child,
      builder:
          (_, value, child) => Transform.translate(offset: value, child: child),
    );
  }
}
