import 'package:bookna_app/core/resources/theme/app_colors.dart';
import 'package:bookna_app/core/resources/constants/app_strings.dart';
import 'package:bookna_app/core/resources/constants/app_values.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorPage({super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: AppIconSize.s80,
              ),
              const SizedBox(height: AppSize.s20),
              const Text('${AppStrings.oops}!'),
              const SizedBox(height: AppSize.s10),
              Text(
                message,
                overflow: TextOverflow.ellipsis,
                maxLines: 7,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSize.s30),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p20,
                  vertical: AppPadding.p10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.r100),

                  color: AppColors.error,
                ),
                child: GestureDetector(
                  onTap: onRetry,
                  child: const Text(AppStrings.tryAgain),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
