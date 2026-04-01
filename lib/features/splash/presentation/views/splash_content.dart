import 'package:bookna_app/core/constants/app_values.dart';
import 'package:bookna_app/core/constants/app_assets.dart';
import 'package:bookna_app/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

class SplashContent extends StatelessWidget {
  final Animation<double> scaleAnimation;
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;

  const SplashContent({
    super.key,
    required this.scaleAnimation,
    required this.fadeAnimation,
    required this.slideAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ScaleTransition(
          scale: scaleAnimation,
          child: Image.asset(AppAssets.splashImage, width: AppSize.s150, height: AppSize.s150),
        ),
        const SizedBox(height: AppSize.s20),
        _buildTitle(),
        const SizedBox(height: AppSize.s20),
        _buildSubtitle(),
      ],
    );
  }

  Widget _buildTitle() => FadeTransition(
        opacity: fadeAnimation,
        child: SlideTransition(
          position: slideAnimation,
          child: const Text(
            AppStrings.appTitle,
            style: TextStyle(fontSize: AppSize.s32, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      );

  Widget _buildSubtitle() => FadeTransition(
        opacity: fadeAnimation,
        child: const Text(
          AppStrings.appSubtitle,
          style: TextStyle(fontSize: AppSize.s16, color: Colors.white70),
        ),
      );
}
