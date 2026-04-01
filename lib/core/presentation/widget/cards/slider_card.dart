import 'package:bookna_app/core/presentation/widget/cards/slider_card_image.dart';
import 'package:bookna_app/core/presentation/widget/others/slider_dots.dart';
import 'package:bookna_app/core/constants/app_constants.dart';
import 'package:bookna_app/core/constants/app_values.dart';
import 'package:bookna_app/core/utils/format_date.dart';
import 'package:bookna_app/core/router/route_function.dart';
import 'package:bookna_app/features/catalog/domain/entities/book.dart';
import 'package:flutter/material.dart';

class SliderCard extends StatelessWidget {
  final int itemIndex;
  final bool isBook;
  final Book book;

  const SliderCard({
    super.key,
    required this.itemIndex,
    required this.isBook,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigateToDetailsView(context, book),
      child: SafeArea(
        child: Stack(
          children: [
            SliderCardImage(imageUrl: book.thumbnail),
            _buildInfoOverlay(context),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoOverlay(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppPadding.p16,
        0,
        AppPadding.p16,
        AppPadding.p10,
      ),
      child: SizedBox(
        height: AppSize.getScreenHeight(context) * 0.55,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (book.title != null)
              Text(
                book.title!,
                maxLines: AppConstants.maxLines2,
                style: textTheme.titleMedium,
              ),
            Text(formatDate(book.publishedDate), style: textTheme.bodyLarge),
            SliderDots(itemIndex: itemIndex),
          ],
        ),
      ),
    );
  }
}
