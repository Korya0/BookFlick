import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:bookna_app/core/resources/app_values.dart';
import 'package:flutter/material.dart';

class EmptyFavoriteText extends StatelessWidget {
  const EmptyFavoriteText({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(AppStrings.favoriteEmpty, style: textTheme.titleMedium),
        Padding(
          padding: const EdgeInsets.only(top: AppPadding.p6),
          child: Text(
            AppStrings.favoriteText,
            style: textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
