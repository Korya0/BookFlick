import 'package:bookna_app/core/resources/app_colors.dart';
import 'package:bookna_app/core/resources/app_values.dart';
import 'package:flutter/material.dart';

class ArrowBackIosButtom extends StatelessWidget {
  const ArrowBackIosButtom({super.key, this.iconSize = AppIconSize.s20});
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p8),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryIconContainer,
        ),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColors.disabledIcon,
          size: iconSize,
        ),
      ),
    );
  }
}
