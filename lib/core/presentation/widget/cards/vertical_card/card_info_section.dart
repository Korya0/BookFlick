import 'package:bookna_app/core/constants/app_constants.dart';
import 'package:bookna_app/core/constants/app_values.dart';
import 'package:bookna_app/core/theme/app_colors.dart';
import 'package:bookna_app/core/utils/format_date.dart';
import 'package:flutter/material.dart';

class CardInfoSection extends StatelessWidget {
  final String? title;
  final String? publishedDate;
  final num? averageRating;
  final String? description;

  const CardInfoSection({
    super.key,
    this.title,
    this.publishedDate,
    this.averageRating,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) _buildTitle(textTheme),
        _buildRatingRow(textTheme),
        if (description != null) _buildDescription(textTheme),
      ],
    );
  }

  Widget _buildTitle(TextTheme textTheme) => Padding(
    padding: const EdgeInsets.only(top: AppPadding.p6),
    child: Text(
      title!,
      maxLines: AppConstants.maxLines3,
      overflow: TextOverflow.ellipsis,
      style: textTheme.titleSmall,
    ),
  );

  Widget _buildRatingRow(TextTheme textTheme) => Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(right: AppPadding.p12),
        child: Text(
          formatDate(publishedDate, outputFormat: 'y'),
          style: textTheme.bodyLarge,
        ),
      ),
      const Icon(
        Icons.star_rate_rounded,
        color: AppColors.ratingIcon,
        size: AppIconSize.s18,
      ),
      Text(averageRating?.toString() ?? 'N/A', style: textTheme.bodyLarge),
    ],
  );

  Widget _buildDescription(TextTheme textTheme) => Padding(
    padding: const EdgeInsets.only(top: AppPadding.p14),
    child: Text(
      description!,
      maxLines: AppConstants.maxLines2,
      overflow: TextOverflow.ellipsis,
      style: textTheme.bodyLarge,
    ),
  );
}
