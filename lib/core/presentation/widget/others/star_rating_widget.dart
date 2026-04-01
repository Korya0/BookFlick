import 'package:bookna_app/core/constants/app_constants.dart';
import 'package:bookna_app/core/theme/app_colors.dart';
import 'package:bookna_app/core/constants/app_values.dart';
import 'package:flutter/material.dart';
import 'package:bookna_app/core/presentation/widget/animations/bounce_in_animation.dart';

class StarRatingWidget extends StatelessWidget {
  final double rating;
  final bool animate;
  final Duration duration;
  final int delay;

  const StarRatingWidget({
    super.key,
    required this.rating,
    this.animate = false,
    this.duration = const Duration(milliseconds: AppConstants.shortAnimationDuration),
    this.delay = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        final star = _buildStar(index);
        return animate
            ? BounceInAnimation(
              delay: delay + (index * 100),
              duration: duration,
              child: star,
            )
            : star;
      }),
    );
  }

  Widget _buildStar(int index) {
    if (index < rating.floor()) {
      return const Icon(
        Icons.star,
        color: AppColors.ratingIcon,
        size: AppIconSize.s20,
      );
    } else if (index < rating.ceil()) {
      return const Icon(
        Icons.star_half,
        color: AppColors.ratingIcon,
        size: AppIconSize.s20,
      );
    } else {
      return const Icon(
        Icons.star_border,
        color: AppColors.ratingIcon,
        size: AppIconSize.s20,
      );
    }
  }
}
