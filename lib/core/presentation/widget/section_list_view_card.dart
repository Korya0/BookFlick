import 'package:bookna_app/core/presentation/widget/image_with_shimmer.dart';
import 'package:bookna_app/core/resources/app_colors.dart';
import 'package:bookna_app/core/resources/app_values.dart';
import 'package:bookna_app/core/utils/functions/route_function.dart';
import 'package:bookna_app/features/books/domain/entities/book.dart';
import 'package:flutter/material.dart';

class SectionListViewCard extends StatelessWidget {
  const SectionListViewCard({
    super.key,
    required this.isBook,
    required this.book,
  });

  final bool isBook;
  final Book book;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: AppSize.s120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              navigateToDetailsView(context, book);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.r8),
              child: ImageWithShimmer(
                imageUrl: book.thumbnail,
                width: AppSize.sInfinity,
                height: AppSize.s175,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (book.title != null)
                Text(
                  book.title as String,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium,
                ),
              Row(
                children: [
                  const Icon(
                    Icons.star_rate_rounded,
                    color: AppColors.ratingIcon,
                    size: AppIconSize.s18,
                  ),
                  Text('${book.averageRating}/10', style: textTheme.bodySmall),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
