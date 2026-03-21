import 'package:bookna_app/core/presentation/widget/error_text.dart';
import 'package:bookna_app/core/presentation/widget/loading_widget.dart';
import 'package:bookna_app/core/resources/app_values.dart';
import 'package:bookna_app/core/utils/setup_services_locator.dart';
import 'package:bookna_app/features/books/data/repo/books_repo_impl.dart';
import 'package:bookna_app/features/books/domain/usecase/get_books_by_title_use_case.dart';
import 'package:bookna_app/features/search/presentation/controller/search_cubit.dart';
import 'package:bookna_app/features/search/presentation/controller/search_state.dart';
import 'package:bookna_app/features/search/presentation/widget/no_result.dart';
import 'package:bookna_app/features/search/presentation/widget/search_field.dart';
import 'package:bookna_app/features/search/presentation/widget/search_grid_view.dart';
import 'package:bookna_app/features/search/presentation/widget/search_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              SearchCubit(GetBooksByTitleUseCase(getIt.get<BooksRepoImpl>())),
      child: const _SearchViewContent(),
    );
  }
}

class _SearchViewContent extends StatelessWidget {
  const _SearchViewContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: AppPadding.p12,
            left: AppPadding.p16,
            right: AppPadding.p16,
          ),
          child: Column(
            children: [
              const SearchField(),
              const SizedBox(height: AppSize.s16),
              Flexible(
                child: BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    if (state is SearchBooksInitial) {
                      return const Center(child: SearchText());
                    } else if (state is SearchBooksLoading) {
                      return const Center(child: LoadingWidget());
                    } else if (state is SearchBooksLoaded) {
                      if (state.books.isEmpty) {
                        return const Center(child: NoResults());
                      }
                      return SearchGridView(books: state.books);
                    } else if (state is SearchBooksError) {
                      return const Center(child: ErrorText());
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
