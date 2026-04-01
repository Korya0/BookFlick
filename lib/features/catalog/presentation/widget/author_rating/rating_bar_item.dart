import 'package:bookna_app/core/presentation/widget/animations/bounce_in_animation.dart';
import 'package:bookna_app/core/presentation/widget/animations/scale_animation.dart';
import 'package:bookna_app/core/constants/app_strings.dart';
import 'package:bookna_app/core/constants/app_values.dart';
import 'package:bookna_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class RatingBarItem extends StatelessWidget {
  final int stars;
  final double percentage;
  final int index;
  final Duration duration;
  final Curve curve;
  const RatingBarItem({
    super.key,
    required this.stars,
    required this.percentage,
    required this.index,
    required this.duration,
    required this.curve,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p4),
      child: Row(
        children: [
          ScaleAnimation(
            delay: 500 + (index * 100),
            duration: duration,
            child: Text('$stars ${AppStrings.stars}'),
          ),
          const SizedBox(width: AppSize.s8),
          Expanded(child: _buildProgressBar()),
          const SizedBox(width: AppSize.s8),
          _buildPercentageLabel(),
        ],
      ),
    );
  }

  Widget _buildProgressBar() => Container(
    height: AppSize.s8,
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(AppRadius.r4),
    ),
    child: TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration,
      curve: curve,
      builder:
          (_, val, _) => FractionallySizedBox(
            widthFactor: val,
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.getRatingColor(stars),
                borderRadius: BorderRadius.circular(AppRadius.r4),
              ),
            ),
          ),
    ),
  );

  Widget _buildPercentageLabel() => BounceInAnimation(
    delay: 600 + (index * 100),
    duration: duration,
    child: TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: percentage),
      duration: duration,
      builder:
          (_, v, _) => Text(
            '${v.toStringAsFixed(1)}%',
            style: TextStyle(
              color: AppColors.getRatingColor(stars).withValues(alpha: 0.8),
              fontWeight: FontWeight.w600,
            ),
          ),
    ),
  );
}
