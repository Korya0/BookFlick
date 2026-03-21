import 'package:bookna_app/core/resources/app_colors.dart';
import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:bookna_app/core/resources/app_values.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final Function() onSeeAllTap;

  const SectionHeader({
    super.key,
    required this.title,
    required this.onSeeAllTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppPadding.p4,
        horizontal: AppPadding.p16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: textTheme.titleSmall),
          InkWell(
            onTap: onSeeAllTap,
            child: Row(
              children: [
                Text(AppStrings.seeAll, style: textTheme.bodySmall),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: AppIconSize.s12,
                  color: AppColors.disabledIcon,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
