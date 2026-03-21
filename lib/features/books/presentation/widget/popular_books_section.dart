import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bookna_app/core/presentation/widget/section_header.dart';
import 'package:bookna_app/core/presentation/widget/section_list_view.dart';
import 'package:bookna_app/core/presentation/widget/section_list_view_card.dart';
import 'package:bookna_app/core/resources/app_routes.dart';
import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:bookna_app/core/resources/app_values.dart';
import 'package:bookna_app/features/books/presentation/controller/popular_books_cubit/popular_books_cubit.dart';
import 'package:bookna_app/features/books/presentation/controller/popular_books_cubit/popular_books_state.dart';

class PopularBooksSection extends StatelessWidget {
  const PopularBooksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularBooksCubit, PopularBooksState>(
      builder: (context, state) {
        return SliverList(
          delegate: SliverChildListDelegate([
            SectionHeader(
              title: AppStrings.popularBooks,
              onSeeAllTap: () {
                context.goNamed(AppRoutes.popularBooks);
              },
            ),
            if (state is PopularBooksLoaded)
              SectionListView(
                height: AppSize.s240,
                itemCount: state.books.length, // Will now be 40
                itemBuilder: (context, index) {
                  return SectionListViewCard(
                    isBook: true,
                    book: state.books[index],
                  );
                },
              )
            else
              const SizedBox.shrink(),
          ]),
        );
      },
    );
  }
}
