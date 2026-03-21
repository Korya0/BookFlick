import 'package:bookna_app/core/resources/app_values.dart';
import 'package:flutter/material.dart';
import 'package:bookna_app/core/resources/app_colors.dart';

class CategoryListWidget extends StatelessWidget {
  final List<String> categories;
  final String selected;
  final Function(String) onSelect;

  const CategoryListWidget({
    super.key,
    required this.categories,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s45,
      color: AppColors.primaryBackground,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
        itemBuilder: (context, index) {
          final category = categories[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p6),
            child: ChoiceChip(
              label: Text(
                category,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color:
                      category == selected
                          ? AppColors.secondaryText
                          : AppColors.primaryText,
                ),
              ),
              selected: category == selected,
              onSelected: (_) => onSelect(category),
              selectedColor: AppColors.activeIcon,
              backgroundColor: AppColors.primaryBackground,
              checkmarkColor: AppColors.secondaryText,
              showCheckmark: false,
              side: const BorderSide(
                color: AppColors.textFieldBorder,
                width: AppSize.s1,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s20),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p16,
                vertical: AppPadding.p8,
              ),
            ),
          );
        },
      ),
    );
  }
}
