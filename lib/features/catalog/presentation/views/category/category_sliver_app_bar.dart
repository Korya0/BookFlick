import 'package:bookna_app/core/theme/app_colors.dart';
import 'package:bookna_app/core/constants/app_strings.dart';
import 'package:bookna_app/core/constants/app_values.dart';
import 'package:bookna_app/core/presentation/widget/layout/custom_app_bar.dart';
import 'package:bookna_app/features/catalog/presentation/widgets/category/category_list_widget.dart';
import 'package:flutter/material.dart';

class CategorySliverAppBar extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategorySliverAppBar({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.primaryBackground,
      title: const CustomAppBar(title: AppStrings.categories),
      pinned: true,
      expandedHeight: AppSize.s45,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(AppSize.s45),
        child: CategoryListWidget(
          categories: AppStrings.categoriesList,
          selected: selectedCategory,
          onSelect: onCategorySelected,
        ),
      ),
    );
  }
}
