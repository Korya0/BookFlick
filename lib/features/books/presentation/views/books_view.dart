import 'package:bookna_app/core/presentation/views/error_page.dart';
import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:bookna_app/features/books/presentation/widget/popular_books_section.dart';
import 'package:bookna_app/features/books/presentation/widget/slider_section.dart';
import 'package:bookna_app/features/books/presentation/widget/top_rated_books_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookna_app/core/presentation/widget/loading_widget.dart';
import 'package:bookna_app/features/books/presentation/controller/books_cubit/books_cubit.dart';
import 'package:bookna_app/features/books/presentation/controller/books_cubit/books_state.dart';
import 'package:bookna_app/features/books/presentation/controller/popular_books_cubit/popular_books_cubit.dart';
import 'package:bookna_app/features/books/presentation/controller/popular_books_cubit/popular_books_state.dart';
import 'package:bookna_app/features/books/presentation/controller/top_rated_cubit/top_rated_cubit.dart';
import 'package:bookna_app/features/books/presentation/controller/top_rated_cubit/top_rated_state.dart';

class BooksView extends StatelessWidget {
  const BooksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SliderBooksCubit, SliderBooksState>(
        builder: (context, sliderState) {
          return BlocBuilder<PopularBooksCubit, PopularBooksState>(
            builder: (context, popularState) {
              return BlocBuilder<TopRatedBooksCubit, TopRatedBooksState>(
                builder: (context, topRatedState) {
                  // Handle combined error state
                  if (sliderState is SliderBooksError ||
                      popularState is PopularBooksError ||
                      topRatedState is TopRatedBooksError) {
                    return ErrorPage(
                      message: _getErrorMessage(
                        sliderState,
                        popularState,
                        topRatedState,
                      ),
                      onRetry: () {
                        _retryAll(context);
                      },
                    );
                  }

                  // Handle loading state
                  if (sliderState is SliderBooksLoading ||
                      popularState is PopularBooksLoading ||
                      topRatedState is TopRatedBooksLoading) {
                    return const LoadingWidget();
                  }

                  // Handle loaded state
                  return CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      if (sliderState is SliderBooksLoaded)
                        const SliderSection(),
                      if (popularState is PopularBooksLoaded)
                        const PopularBooksSection(),
                      if (topRatedState is TopRatedBooksLoaded)
                        const TopRatedBooksSection(),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  String _getErrorMessage(
    SliderBooksState sliderState,
    PopularBooksState popularState,
    TopRatedBooksState topRatedState,
  ) {
    if (sliderState is SliderBooksError) return sliderState.message;
    if (popularState is PopularBooksError) return popularState.message;
    if (topRatedState is TopRatedBooksError) return topRatedState.message;
    return AppStrings.anunknownerroroccurred;
  }

  void _retryAll(BuildContext context) {
    context.read<SliderBooksCubit>().getSliderBooks();
    context.read<PopularBooksCubit>().getPopularBooksLimited();
    context.read<TopRatedBooksCubit>().getTopRatedBooksLimited();
  }
}
