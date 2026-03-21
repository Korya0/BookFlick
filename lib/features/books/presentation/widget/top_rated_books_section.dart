import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bookna_app/core/presentation/widget/section_header.dart';
import 'package:bookna_app/core/presentation/widget/section_list_view.dart';
import 'package:bookna_app/core/presentation/widget/section_list_view_card.dart';
import 'package:bookna_app/core/resources/app_routes.dart';
import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:bookna_app/core/resources/app_values.dart';
import 'package:bookna_app/features/books/presentation/controller/top_rated_cubit/top_rated_cubit.dart';
import 'package:bookna_app/features/books/presentation/controller/top_rated_cubit/top_rated_state.dart';

class TopRatedBooksSection extends StatelessWidget {
  const TopRatedBooksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopRatedBooksCubit, TopRatedBooksState>(
      builder: (context, state) {
        return SliverList(
          delegate: SliverChildListDelegate([
            SectionHeader(
              title: AppStrings.topRatedBooks,
              onSeeAllTap: () {
                context.goNamed(AppRoutes.topRatedBooks);
              },
            ),
            if (state is TopRatedBooksLoaded)
              SectionListView(
                height: AppSize.s240,
                itemCount: state.books.length,
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
