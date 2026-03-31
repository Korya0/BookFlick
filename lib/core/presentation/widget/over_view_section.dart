import 'package:bookna_app/core/resources/constants/app_constants.dart';
import 'package:bookna_app/core/presentation/widget/section_title.dart';
import 'package:bookna_app/core/resources/constants/app_strings.dart';
import 'package:bookna_app/core/resources/constants/app_values.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class OverviewSection extends StatelessWidget {
  final String overview;

  const OverviewSection({super.key, required this.overview});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: AppStrings.description),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
          child: ReadMoreText(
            overview,
            trimLines: AppConstants.detailsOverviewTrimLines,
            trimMode: TrimMode.Line,
            trimCollapsedText: AppStrings.showMore,
            trimExpandedText: AppStrings.showLess,
            style: Theme.of(context).textTheme.bodyLarge,
            moreStyle: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
            lessStyle: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
