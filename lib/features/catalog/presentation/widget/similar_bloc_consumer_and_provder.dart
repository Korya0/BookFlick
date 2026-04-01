import 'package:bookna_app/core/constants/app_strings.dart';
import 'package:bookna_app/features/catalog/presentation/widget/similar_books_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookna_app/core/presentation/views/error_page.dart';
import 'package:bookna_app/core/presentation/widget/loading/loading_widget.dart';
import 'package:bookna_app/core/di/di_locator.dart';
import 'package:bookna_app/features/catalog/data/repo/books_repo_impl.dart';
import 'package:bookna_app/features/catalog/domain/entities/book.dart';
import 'package:bookna_app/features/catalog/domain/usecase/get_books_by_category_path_use_case.dart';
import 'package:bookna_app/features/catalog/presentation/controller/similar_cubit/similar_cubit.dart';
import 'package:bookna_app/features/catalog/presentation/controller/similar_cubit/similar_state.dart';

class SimilarBlocConsumerAndProvider extends StatelessWidget {
  final Book book;

  const SimilarBlocConsumerAndProvider({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => SimilarCubit(
            GetBooksByCategoryPathUseCase(getIt.get<BooksRepoImpl>()),
          )..fetchBooksByCategory(
            book.categories?.first ?? AppStrings.fiction,
            isInitial: true,
          ),
      child: BlocConsumer<SimilarCubit, SimilarState>(
        listener: (context, state) {
          if (state is SimilarBooksError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is SimilarBooksLoading) {
            return const SliverToBoxAdapter(child: LoadingWidget());
          }

          if (state is SimilarBooksError) {
            return SliverToBoxAdapter(
              child: ErrorPage(
                message: state.message,
                onRetry:
                    () => context.read<SimilarCubit>().fetchBooksByCategory(
                      book.categories?.first ?? AppStrings.fiction,
                      isInitial: true,
                    ),
              ),
            );
          }

          return SimilarBooksSection(state: state);
        },
      ),
    );
  }
}
