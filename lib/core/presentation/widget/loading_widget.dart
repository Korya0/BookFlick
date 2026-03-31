import 'package:bookna_app/core/resources/theme/app_colors.dart';
import 'package:bookna_app/core/resources/constants/app_values.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        strokeWidth: AppSize.s4,
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.activeIcon),
      ),
    );
  }
}
