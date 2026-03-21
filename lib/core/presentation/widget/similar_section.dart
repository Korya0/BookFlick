import 'package:bookna_app/core/presentation/widget/section_list_view.dart';
import 'package:bookna_app/core/presentation/widget/section_list_view_card.dart';
import 'package:bookna_app/core/presentation/widget/section_title.dart';
import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:bookna_app/core/resources/app_values.dart';
import 'package:bookna_app/features/books/domain/entities/book.dart';
import 'package:flutter/material.dart';

class SimilarSection extends StatelessWidget {
  const SimilarSection({super.key, required this.isBook, required this.books});

  final bool isBook;
  final List<Book> books;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: AppStrings.similar),
        SectionListView(
          height: AppSize.s240,
          itemCount: books.length,
          itemBuilder:
              (context, index) =>
                  SectionListViewCard(isBook: isBook, book: books[index]),
        ),
      ],
    );
  }
}
