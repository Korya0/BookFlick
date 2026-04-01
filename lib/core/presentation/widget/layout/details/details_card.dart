import 'package:bookna_app/core/constants/app_values.dart';
import 'package:bookna_app/core/presentation/widget/cards/slider_card_image.dart';
import 'package:bookna_app/core/presentation/widget/layout/details/details_preview_button.dart';
import 'package:bookna_app/core/presentation/widget/layout/details/details_top_actions.dart';
import 'package:bookna_app/core/presentation/widget/layout/details/details_book_info.dart';
import 'package:bookna_app/features/catalog/domain/entities/book.dart';
import 'package:flutter/material.dart';

class DetailsCard extends StatelessWidget {
  final Widget detailsWidget;
  final Book book;

  const DetailsCard({
    required this.detailsWidget,
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SliderCardImage(imageUrl: book.thumbnail),
          _buildInfoOverlay(context),
          DetailsTopActions(book: book),
        ],
      ),
    );
  }

  Widget _buildInfoOverlay(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
    child: SizedBox(
      height: AppSize.getScreenHeight(context) * 0.6,
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppPadding.p8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: DetailsBookInfo(book: book, detailsWidget: detailsWidget),
            ),
            DetailsPreviewButton(previewLink: book.previewLink),
          ],
        ),
      ),
    ),
  );
}
