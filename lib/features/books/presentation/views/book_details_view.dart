import 'package:bookna_app/features/books/presentation/widget/similar_bloc_consumer_and_provder.dart';
import 'package:flutter/material.dart';
import 'package:bookna_app/features/books/domain/entities/book.dart';
import 'package:bookna_app/features/books/presentation/widget/author_section_widget.dart';
import 'package:bookna_app/features/books/presentation/widget/book_details_section.dart';
import 'package:bookna_app/features/books/presentation/widget/overview_section_widget.dart';

class BookDetailsView extends StatelessWidget {
  final Book book;

  const BookDetailsView({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          BookDetailsSection(book: book),
          if (book.description != null)
            OverviewSectionWidget(overview: book.description),
          if (book.authors != null) AuthorSectionWidget(book: book),
          SimilarBlocConsumerAndProvider(book: book),
        ],
      ),
    );
  }
}
