import 'package:bookna_app/core/presentation/views/error_page.dart';
import 'package:bookna_app/core/presentation/widget/loading/loading_widget.dart';
import 'package:bookna_app/core/constants/app_strings.dart';
import 'package:bookna_app/features/catalog/presentation/controller/books_cubit/books_cubit.dart';
import 'package:bookna_app/features/catalog/presentation/controller/books_cubit/books_state.dart';
import 'package:bookna_app/features/catalog/presentation/controller/popular_books_cubit/popular_books_cubit.dart';
import 'package:bookna_app/features/catalog/presentation/controller/popular_books_cubit/popular_books_state.dart';
import 'package:bookna_app/features/catalog/presentation/controller/top_rated_cubit/top_rated_cubit.dart';
import 'package:bookna_app/features/catalog/presentation/controller/top_rated_cubit/top_rated_state.dart';
import 'package:bookna_app/features/catalog/presentation/widget/popular_books_section.dart';
import 'package:bookna_app/features/catalog/presentation/widget/slider_section.dart';
import 'package:bookna_app/features/catalog/presentation/widget/top_rated_books_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BooksMultiBlocBuilder extends StatelessWidget {
  const BooksMultiBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SliderBooksCubit, SliderBooksState>(
      builder:
          (context, slider) =>
              BlocBuilder<PopularBooksCubit, PopularBooksState>(
                builder:
                    (context, popular) =>
                        BlocBuilder<TopRatedBooksCubit, TopRatedBooksState>(
                          builder: (context, topRated) {
                            if (_hasError(slider, popular, topRated)) {
                              return _buildError(
                                context,
                                slider,
                                popular,
                                topRated,
                              );
                            }
                            if (_isLoading(slider, popular, topRated)) {
                              return const LoadingWidget();
                            }
                            return _buildContent(slider, popular, topRated);
                          },
                        ),
              ),
    );
  }

  bool _hasError(
    SliderBooksState s,
    PopularBooksState p,
    TopRatedBooksState t,
  ) =>
      s is SliderBooksError ||
      p is PopularBooksError ||
      t is TopRatedBooksError;
  bool _isLoading(
    SliderBooksState s,
    PopularBooksState p,
    TopRatedBooksState t,
  ) =>
      s is SliderBooksLoading ||
      p is PopularBooksLoading ||
      t is TopRatedBooksLoading;

  Widget _buildError(
    BuildContext context,
    SliderBooksState s,
    PopularBooksState p,
    TopRatedBooksState t,
  ) => ErrorPage(
    message:
        s is SliderBooksError
            ? s.message
            : (p is PopularBooksError
                ? p.message
                : (t is TopRatedBooksError
                    ? t.message
                    : AppStrings.anunknownerroroccurred)),
    onRetry: () => _retryAll(context),
  );

  Widget _buildContent(
    SliderBooksState s,
    PopularBooksState p,
    TopRatedBooksState t,
  ) => CustomScrollView(
    physics: const BouncingScrollPhysics(),
    slivers: [
      if (s is SliderBooksLoaded) const SliderSection(),
      if (p is PopularBooksLoaded) const PopularBooksSection(),
      if (t is TopRatedBooksLoaded) const TopRatedBooksSection(),
    ],
  );

  void _retryAll(BuildContext context) {
    context.read<SliderBooksCubit>().getSliderBooks();
    context.read<PopularBooksCubit>().getPopularBooksLimited();
    context.read<TopRatedBooksCubit>().getTopRatedBooksLimited();
  }
}
