import 'package:flutter/material.dart';
import 'package:bookna_app/core/presentation/widget/author_section.dart';
import 'package:bookna_app/features/books/domain/entities/book.dart';

class AuthorSectionWidget extends StatelessWidget {
  final Book book;

  const AuthorSectionWidget({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child: AuthorSection(book: book));
  }
}
