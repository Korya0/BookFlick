import 'package:bookna_app/core/presentation/widget/animations/fade_in_animation.dart';
import 'package:bookna_app/core/presentation/widget/animations/scale_animation.dart';
import 'package:bookna_app/core/presentation/widget/animations/spin_animation.dart';
import 'package:bookna_app/core/constants/app_values.dart';
import 'package:bookna_app/core/theme/app_colors.dart';
import 'package:bookna_app/features/catalog/presentation/widget/author_stats/stat_item_model.dart';
import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final StatItem stat;
  final int index;
  final Duration duration;
  final Curve curve;

  const StatCard({
    super.key,
    required this.stat,
    required this.index,
    required this.duration,
    required this.curve,
  });

  @override
  Widget build(BuildContext context) {
    return SpinAnimation(
      delay: 300 + (index * 150),
      duration: duration,
      child: Card(
        color: AppColors.primaryBackground,
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Column(
            children: [
              ScaleAnimation(
                delay: 400 + (index * 150),
                duration: duration,
                child: _buildIcon(),
              ),
              const SizedBox(height: AppSize.s8),
              _buildTitle(),
              const SizedBox(height: AppSize.s4),
              _buildValue(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() => Icon(
    stat.icon,
    size: AppIconSize.s30,
    color: AppColors.getIconColor(stat.title),
  );

  Widget _buildTitle() => FadeInAnimation(
    delay: 500 + (index * 150),
    duration: duration,
    child: Text(
      stat.title,
      style: const TextStyle(fontSize: 14, color: AppColors.secondaryText),
    ),
  );

  Widget _buildValue() => TweenAnimationBuilder<int>(
    tween: IntTween(begin: 0, end: stat.value),
    duration: duration,
    curve: curve,
    builder:
        (_, value, _) => Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryText,
          ),
        ),
  );
}
