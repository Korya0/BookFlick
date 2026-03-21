import 'package:bookna_app/core/presentation/widget/custom_app_bar.dart';

import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:bookna_app/core/resources/app_values.dart';
import 'package:bookna_app/features/favorite/presentation/wigets/body_favorite_view.dart';
import 'package:flutter/material.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: AppStrings.favorite),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.p12,
          vertical: AppPadding.p6,
        ),
        child: BodyFavoriteView(),
      ),
    );
  }
}
