import 'package:bookna_app/core/presentation/widget/animations/bounce_in_animation.dart';
import 'package:bookna_app/core/presentation/widget/animations/fade_in_animation.dart';
import 'package:bookna_app/core/presentation/widget/others/star_rating_widget.dart';
import 'package:bookna_app/core/constants/app_strings.dart';
import 'package:bookna_app/core/constants/app_values.dart';
import 'package:bookna_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class RatingHeader extends StatelessWidget {
  final double? ratingAverage;
  final int ratingCount;
  final Duration animationDuration;
  const RatingHeader({
    super.key,
    required this.ratingAverage,
    required this.ratingCount,
    required this.animationDuration,
  });

  @override
  Widget build(BuildContext context) {
    if (ratingAverage == null && ratingCount == 0) return _buildNoRatings();
    return Row(
      children: [
        if (ratingAverage != null) _buildAverageDisplay(),
        const SizedBox(width: AppSize.s16),
        _buildRatingInfo(),
      ],
    );
  }

  Widget _buildAverageDisplay() => BounceInAnimation(
    delay: 200,
    duration: animationDuration,
    child: TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: ratingAverage),
      duration: animationDuration,
      curve: Curves.elasticOut,
      builder:
          (_, val, _) => Text(
            val.toStringAsFixed(1),
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: AppColors.ratingIcon,
            ),
          ),
    ),
  );

  Widget _buildRatingInfo() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (ratingAverage != null)
        StarRatingWidget(
          rating: ratingAverage!,
          animate: true,
          duration: animationDuration,
          delay: 300,
        ),
      if (ratingCount > 0) _buildCountInfo(),
    ],
  );

  Widget _buildCountInfo() => FadeInAnimation(
    delay: 400,
    duration: animationDuration,
    child: TweenAnimationBuilder<int>(
      tween: IntTween(begin: 0, end: ratingCount),
      duration: animationDuration,
      builder:
          (_, val, _) => Text(
            '${AppStrings.basedOn} $val ${AppStrings.ratings.toLowerCase()}',
            style: TextStyle(color: Colors.grey[600]),
          ),
    ),
  );

  Widget _buildNoRatings() => FadeInAnimation(
    delay: 100,
    duration: animationDuration,
    child: Text(
      AppStrings.noRatingsAvailable,
      style: TextStyle(color: Colors.grey[600]),
    ),
  );
}
