import 'package:flutter/material.dart';
import 'package:bookna_app/core/presentation/widget/similar_section.dart';
import 'package:bookna_app/features/books/presentation/controller/similar_cubit/similar_state.dart';

class SimilarBooksSection extends StatelessWidget {
  final SimilarState state;

  const SimilarBooksSection({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state is SimilarBooksLoaded) {
      final loadedState = state as SimilarBooksLoaded;
      return SliverToBoxAdapter(
        child: SimilarSection(isBook: true, books: loadedState.books),
      );
    }
    return const SliverToBoxAdapter(child: SizedBox.shrink());
  }
}
