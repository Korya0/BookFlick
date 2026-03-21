import 'package:bookna_app/core/presentation/views/error_page.dart';
import 'package:bookna_app/core/presentation/widget/custom_app_bar.dart';
import 'package:bookna_app/core/presentation/widget/loading_widget.dart';
import 'package:bookna_app/core/presentation/widget/nice_loading_widget.dart';
import 'package:bookna_app/core/presentation/widget/vertical_list_view_card.dart';
import 'package:bookna_app/core/resources/app_colors.dart';
import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:bookna_app/core/resources/app_values.dart';
import 'package:bookna_app/features/books/presentation/controller/similar_cubit/similar_cubit.dart';
import 'package:bookna_app/features/books/presentation/controller/similar_cubit/similar_state.dart';
import 'package:bookna_app/features/category/presentation/widgets/category_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  final _scrollController = ScrollController();
  late final SimilarCubit _cubit;
  String selectedCategory = AppStrings.defaultCategory;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<SimilarCubit>();
    _scrollController.addListener(_scrollListener);
    _loadInitialData();
  }

  void _loadInitialData() {
    if (_cubit.state is! SimilarBooksLoading) {
      _cubit.fetchBooksByCategory(selectedCategory, isInitial: true);
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _cubit.fetchBooksByCategory(selectedCategory);
    }
  }

  void _onCategorySelected(String category) {
    if (category != selectedCategory) {
      setState(() => selectedCategory = category);
      _cubit.fetchBooksByCategory(category, isInitial: true);
    }
  }

  Future<void> _refreshData() async {
    await _cubit.fetchBooksByCategory(selectedCategory, isInitial: true);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_scrollListener)
      ..dispose();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_cubit.state is! SimilarBooksLoading) {
      _cubit.fetchBooksByCategory(selectedCategory, isInitial: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.primaryBackground,
            title: const CustomAppBar(title: AppStrings.categories),

            pinned: true,
            expandedHeight: AppSize.s45,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(AppSize.s45),
              child: CategoryListWidget(
                categories: AppStrings.categoriesList,
                selected: selectedCategory,
                onSelect: _onCategorySelected,
              ),
            ),
          ),
          BlocBuilder<SimilarCubit, SimilarState>(
            builder: (context, state) {
              if (state is SimilarBooksLoading && _cubit.books.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(child: LoadingWidget()),
                );
              }

              if (state is SimilarBooksError && _cubit.books.isEmpty) {
                return SliverFillRemaining(
                  child: ErrorPage(
                    message: state.message,
                    onRetry: _refreshData,
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index < _cubit.books.length) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.p16,
                          vertical: AppPadding.p8,
                        ),
                        child: VerticalListViewCard(book: _cubit.books[index]),
                      );
                    } else if (_cubit.hasMoreData) {
                      return const Padding(
                        padding: EdgeInsets.all(AppPadding.p16),
                        child: Center(child: NiceLoadingWidget()),
                      );
                    }
                    return const SizedBox();
                  },
                  childCount:
                      _cubit.books.length + (_cubit.hasMoreData ? 1 : 0),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
