import 'package:bookna_app/core/theme/app_colors.dart';
import 'package:bookna_app/core/constants/app_values.dart';
import 'package:bookna_app/core/router/route_function.dart';
import 'package:bookna_app/core/presentation/widget/others/favorite_icon_bloc_builder.dart';
import 'package:bookna_app/core/presentation/widget/cards/vertical_card/card_thumbnail.dart';
import 'package:bookna_app/core/presentation/widget/cards/vertical_card/card_info_section.dart';
import 'package:bookna_app/features/catalog/domain/entities/book.dart';
import 'package:flutter/material.dart';

class VerticalListViewCard extends StatelessWidget {
  final Book book;

  const VerticalListViewCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigateToDetailsView(context, book),
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
            CardThumbnail(imageUrl: book.thumbnail),
            Expanded(child: _buildInfoSection()),
            FavoriteIconBlocBuilder(book: book, iconSize: AppIconSize.s24),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection() => CardInfoSection(
    title: book.title,
    publishedDate: book.publishedDate,
    averageRating: book.averageRating,
    description: book.description,
  );
}
