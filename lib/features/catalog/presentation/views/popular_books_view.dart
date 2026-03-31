import 'package:bookna_app/features/catalog/presentation/widget/popular_books_content.dart';
import 'package:flutter/material.dart';
import 'package:bookna_app/core/presentation/widget/custom_app_bar.dart';
import 'package:bookna_app/core/resources/constants/app_strings.dart';

class PopularBooksView extends StatelessWidget {
  const PopularBooksView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: AppStrings.popularBooks),
      body: PopularBooksContent(),
    );
  }
}
