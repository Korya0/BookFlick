// ignore_for_file: library_private_types_in_public_api

import 'package:bookna_app/core/resources/app_colors.dart';
import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:bookna_app/core/resources/app_values.dart';
import 'package:bookna_app/features/books/domain/entities/author.dart';
import 'package:flutter/material.dart';

class AuthorReadingStatsWidget extends StatefulWidget {
  final Author author;
  final Duration animationDuration;
  final Curve animationCurve;

  const AuthorReadingStatsWidget({
    super.key,
    required this.author,
    this.animationDuration = const Duration(milliseconds: 1000),
    this.animationCurve = Curves.easeOutBack,
  });

  @override
  _AuthorReadingStatsWidgetState createState() =>
      _AuthorReadingStatsWidgetState();
}

class _AuthorReadingStatsWidgetState extends State<AuthorReadingStatsWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stats = [
      _StatItem(
        title: AppStrings.wantToRead,
        value: (widget.author.wantToReadCount ?? 0).toInt(),
        icon: Icons.bookmark,
      ),
      _StatItem(
        title: AppStrings.currentlyReading,
        value: (widget.author.currentlyReadingCount ?? 0).toInt(),
        icon: Icons.menu_book,
      ),
      _StatItem(
        title: AppStrings.alreadyRead,
        value: (widget.author.alreadyReadCount ?? 0).toInt(),
        icon: Icons.check_circle,
      ),
      _StatItem(
        title: AppStrings.totalLogs,
        value: (widget.author.readingLogCount ?? 0).toInt(),
        icon: Icons.library_books,
      ),
    ];

    return SlideInAnimation(
      delay: 0,
      duration: widget.animationDuration,
      curve: widget.animationCurve,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.readingStats,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppSize.s16),
          if (stats.any((stat) => stat.value > 0)) ...[
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children:
                  stats
                      .where((stat) => stat.value > 0)
                      .map((stat) => _buildStatCard(stat, stats.indexOf(stat)))
                      .toList(),
            ),
          ] else
            FadeInAnimation(
              delay: 200,
              duration: widget.animationDuration,
              child: Text(
                AppStrings.noReadingStatsAvailable,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStatCard(_StatItem stat, int index) {
    return SpinAnimation(
      delay: 300 + (index * 150), // Adjusted delay for smoother sequence
      duration: widget.animationDuration,
      child: Card(
        color: AppColors.primaryBackground,
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Column(
            children: [
              ScaleAnimation(
                delay: 400 + (index * 150),
                duration: widget.animationDuration,
                child: Icon(
                  stat.icon,
                  size: AppIconSize.s30,
                  color: AppColors.getIconColor(stat.title),
                ),
              ),
              const SizedBox(height: AppSize.s8),
              FadeInAnimation(
                delay: 500 + (index * 150),
                duration: widget.animationDuration,
                child: Text(
                  stat.title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.secondaryText,
                  ),
                ),
              ),
              const SizedBox(height: AppSize.s4),
              TweenAnimationBuilder<int>(
                tween: IntTween(begin: 0, end: stat.value),
                duration: widget.animationDuration,
                curve: widget.animationCurve,
                builder:
                    (_, value, __) => Text(
                      value.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryText,
                      ),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatItem {
  final String title;
  final int value;
  final IconData icon;

  _StatItem({required this.title, required this.value, required this.icon});
}

// Animation Widgets
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

class FadeInAnimation extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final int delay;

  const FadeInAnimation({
    super.key,
    required this.child,
    required this.duration,
    this.delay = 0,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration,
      curve: Interval(
        delay / (delay + duration.inMilliseconds),
        1.0,
        curve: Curves.easeIn,
      ),
      builder: (_, value, child) => Opacity(opacity: value, child: child),
      child: child,
    );
  }
}

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
      tween: Tween(begin: 0.0, end: 2 * 3.14159), // Full 360-degree rotation
      duration: duration,
      curve: Interval(
        delay / (delay + duration.inMilliseconds),
        1.0,
        curve: Curves.easeOut,
      ),
      builder: (_, value, child) {
        return Transform.rotate(angle: value, child: child);
      },
      child: child,
    );
  }
}

class ScaleAnimation extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final int delay;

  const ScaleAnimation({
    super.key,
    required this.child,
    required this.duration,
    this.delay = 0,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration,
      curve: Interval(
        delay / (delay + duration.inMilliseconds),
        1.0,
        curve: Curves.easeOutBack,
      ),
      builder: (_, value, child) => Transform.scale(scale: value, child: child),
      child: child,
    );
  }
}
