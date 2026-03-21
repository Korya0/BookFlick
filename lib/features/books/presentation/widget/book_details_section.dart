import 'package:flutter/material.dart';
import 'package:bookna_app/core/presentation/widget/details_card.dart';
import 'package:bookna_app/features/books/domain/entities/book.dart';
import 'package:bookna_app/features/books/presentation/widget/books_card_details.dart';

class BookDetailsSection extends StatelessWidget {
  final Book book;

  const BookDetailsSection({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: DetailsCard(
        book: book,
        detailsWidget: BooksCardDetails(book: book),
      ),
    );
  }
}
