import 'package:bookna_app/core/constants/app_values.dart';
import 'package:bookna_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DetailsRatingRow extends StatelessWidget {
  final num? averageRating;
  final num? ratingsCount;

  const DetailsRatingRow({
    super.key,
    required this.averageRating,
    required this.ratingsCount,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      spacing: 3,
      children: [
        const Icon(
          Icons.star_rate_rounded,
          color: AppColors.ratingIcon,
          size: AppIconSize.s18,
        ),
        Text(averageRating?.toString() ?? '0.0', style: textTheme.bodyMedium),
        Text(
          '(${ratingsCount?.toString() ?? '0'})',
          style: textTheme.bodySmall,
        ),
      ],
    );
  }
}
