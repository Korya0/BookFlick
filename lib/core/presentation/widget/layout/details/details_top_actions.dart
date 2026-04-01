import 'package:bookna_app/core/constants/app_values.dart';
import 'package:bookna_app/core/presentation/widget/buttons/arrow_back_ios_buttom.dart';
import 'package:bookna_app/core/presentation/widget/others/favorite_icon_bloc_builder.dart';
import 'package:bookna_app/features/catalog/domain/entities/book.dart';
import 'package:flutter/material.dart';

class DetailsTopActions extends StatelessWidget {
  final Book book;

  const DetailsTopActions({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppPadding.p12,
        left: AppPadding.p16,
        right: AppPadding.p16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const ArrowBackIosButtom(),
          FavoriteIconBlocBuilder(book: book),
        ],
      ),
    );
  }
}
