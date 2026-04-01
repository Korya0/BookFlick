import 'package:bookna_app/features/catalog/presentation/views/books_multi_bloc_builder.dart';
import 'package:flutter/material.dart';

class BooksView extends StatelessWidget {
  const BooksView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BooksMultiBlocBuilder(),
    );
  }
}
