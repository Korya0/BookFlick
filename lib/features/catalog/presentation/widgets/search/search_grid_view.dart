import 'package:bookna_app/core/resources/constants/app_values.dart';
import 'package:bookna_app/features/catalog/domain/entities/book.dart';
import 'package:bookna_app/features/catalog/presentation/widgets/search/grid_view_card.dart';
import 'package:flutter/material.dart';

class SearchGridView extends StatelessWidget {
  final List<Book> books;

  const SearchGridView({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p12),
      itemCount: books.length,
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.55,
      ),
      itemBuilder: (context, index) {
        return GridViewCard(book: books[index]);
      },
    );
  }
}
