import 'package:bookna_app/core/theme/app_colors.dart';
import 'package:bookna_app/core/constants/app_strings.dart';
import 'package:bookna_app/features/catalog/presentation/controller/similar_cubit/similar_cubit.dart';
import 'package:bookna_app/features/catalog/presentation/controller/similar_cubit/similar_state.dart';
import 'package:bookna_app/features/catalog/presentation/views/category/category_sliver_app_bar.dart';
import 'package:bookna_app/features/catalog/presentation/views/category/category_books_list.dart';
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

  @override
  void dispose() {
    _scrollController
      ..removeListener(_scrollListener)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          CategorySliverAppBar(
            selectedCategory: selectedCategory,
            onCategorySelected: _onCategorySelected,
          ),
          CategoryBooksList(
            onRefresh:
                () => _cubit.fetchBooksByCategory(
                  selectedCategory,
                  isInitial: true,
                ),
          ),
        ],
      ),
    );
  }
}
