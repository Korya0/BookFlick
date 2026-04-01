import 'package:bookna_app/core/api/network/api_constants.dart';
import 'package:bookna_app/core/presentation/widget/cards/author_card.dart';
import 'package:bookna_app/core/presentation/widget/lists/section_list_view.dart';
import 'package:bookna_app/core/presentation/widget/layout/section_title.dart';
import 'package:bookna_app/core/router/app_routes.dart';
import 'package:bookna_app/core/constants/app_strings.dart';
import 'package:bookna_app/core/constants/app_values.dart';
import 'package:bookna_app/features/catalog/domain/entities/book.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthorSection extends StatelessWidget {
  const AuthorSection({super.key, required this.book});
  final Book book;
  @override
  Widget build(BuildContext context) {
    return book.authors != null
        ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(title: AppStrings.author),
            SectionListView(
              height: AppSize.s175,
              itemCount: book.authors!.length,
              itemBuilder:
                  (context, index) => AuthorCard(
                    imageUrl: ApiConstants.authorPlaceholder,
                    name: book.authors![index],
                    onTap:
                        () => context.goNamed(
                          AppRoutes.authorInfo,
                          extra: book.authors![index],
                        ),
                  ),
            ),
          ],
        )
        : const SizedBox.shrink();
  }
}
