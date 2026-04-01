import 'package:flutter/material.dart';
import 'package:bookna_app/core/presentation/widget/sections/author_section.dart';
import 'package:bookna_app/features/catalog/domain/entities/book.dart';

class AuthorSectionWidget extends StatelessWidget {
  final Book book;

  const AuthorSectionWidget({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child: AuthorSection(book: book));
  }
}
