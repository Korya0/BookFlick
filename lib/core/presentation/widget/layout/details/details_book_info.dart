import 'package:bookna_app/core/constants/app_constants.dart';
import 'package:bookna_app/core/constants/app_values.dart';
import 'package:bookna_app/core/presentation/widget/layout/details/details_rating_row.dart';
import 'package:bookna_app/features/catalog/domain/entities/book.dart';
import 'package:flutter/material.dart';

class DetailsBookInfo extends StatelessWidget {
  final Book book;
  final Widget detailsWidget;

  const DetailsBookInfo({
    super.key,
    required this.book,
    required this.detailsWidget,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: AppSize.getScreenWidth(context) * 0.7,
          ),
          child: _buildTitle(textTheme),
        ),
        DetailsRatingRow(
          averageRating: book.averageRating,
          ratingsCount: book.ratingsCount,
        ),
      ],
    );
  }

  Widget _buildTitle(TextTheme textTheme) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (book.title != null)
        Text(
          book.title!,
          maxLines: AppConstants.maxLines2,
          overflow: TextOverflow.ellipsis,
          style: textTheme.titleMedium,
        ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: AppPadding.p4),
        child: detailsWidget,
      ),
    ],
  );
}
