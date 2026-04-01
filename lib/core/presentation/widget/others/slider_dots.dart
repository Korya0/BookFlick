import 'package:bookna_app/core/constants/app_constants.dart';
import 'package:bookna_app/core/constants/app_values.dart';
import 'package:bookna_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SliderDots extends StatelessWidget {
  final int itemIndex;

  const SliderDots({super.key, required this.itemIndex});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppPadding.p4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(
          AppConstants.carouselSliderItemsCount,
          (indexDot) => Container(
            margin: const EdgeInsets.only(right: AppMargin.m10),
            width: indexDot == itemIndex ? AppSize.s30 : AppSize.s6,
            height: AppSize.s6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.r6),
              color:
                  indexDot == itemIndex
                      ? AppColors.activeDot
                      : AppColors.inactiveDot,
            ),
          ),
        ),
      ),
    );
  }
}
