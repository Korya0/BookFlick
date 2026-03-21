import 'package:bookna_app/core/presentation/widget/favorite_icon_bloc_builder.dart';
import 'package:bookna_app/core/presentation/widget/image_with_shimmer.dart';
import 'package:bookna_app/core/resources/app_colors.dart';
import 'package:bookna_app/core/resources/app_values.dart';
import 'package:bookna_app/core/utils/functions/format_date.dart';
import 'package:bookna_app/core/utils/functions/route_function.dart';
import 'package:bookna_app/features/books/domain/entities/book.dart';
import 'package:flutter/material.dart';

class VerticalListViewCard extends StatelessWidget {
  const VerticalListViewCard({super.key, required this.book});
  final Book book;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        navigateToDetailsView(context, book);
      },
      child: Container(
        height: AppSize.s175,
        decoration: BoxDecoration(
          color: AppColors.secondaryBackground,
          borderRadius: BorderRadius.circular(AppRadius.r8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.r8),
                child: ImageWithShimmer(
                  imageUrl: book.thumbnail,

                  width: AppSize.s110,
                  height: AppSize.sInfinity,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (book.title != null)
                    Padding(
                      padding: const EdgeInsets.only(top: AppPadding.p6),
                      child: Text(
                        book.title as String, // Use book data
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.titleSmall,
                      ),
                    ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: AppPadding.p12),
                        child: Text(
                          formatDate(book.publishedDate, outputFormat: 'y'),

                          textAlign: TextAlign.center,
                          style: textTheme.bodyLarge,
                        ),
                      ),
                      const Icon(
                        Icons.star_rate_rounded,
                        color: AppColors.ratingIcon,
                        size: AppIconSize.s18,
                      ),
                      Text(
                        book.averageRating?.toString() ??
                            'N/A', // Use book data
                        style: textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  if (book.description != null)
                    Padding(
                      padding: const EdgeInsets.only(top: AppPadding.p14),
                      child: Text(
                        book.description as String,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyLarge,
                      ),
                    ),
                ],
              ),
            ),
            FavoriteIconBlocBuilder(book: book, iconSize: AppIconSize.s24),
          ],
        ),
      ),
    );
  }
}
