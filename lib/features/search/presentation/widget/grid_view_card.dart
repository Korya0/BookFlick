import 'package:bookna_app/core/presentation/widget/image_with_shimmer.dart';
import 'package:bookna_app/core/resources/app_values.dart';
import 'package:bookna_app/core/utils/functions/route_function.dart';
import 'package:bookna_app/features/books/domain/entities/book.dart';
import 'package:flutter/material.dart';

class GridViewCard extends StatelessWidget {
  const GridViewCard({super.key, required this.book});
  final Book book;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        GestureDetector(
          onTap: () => navigateToDetailsView(context, book),
          child: AspectRatio(
            aspectRatio: 2 / 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.r8),
              child: ImageWithShimmer(
                imageUrl: book.thumbnail,
                width: AppSize.sInfinity,
                height: AppSize.s150,
              ),
            ),
          ),
        ),
        if (book.authors != null)
          Expanded(
            child: Text(
              book.title!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyMedium,
            ),
          ),
      ],
    );
  }
}
