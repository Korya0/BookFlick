import 'package:bookna_app/core/constants/app_values.dart';
import 'package:bookna_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AdditionalInfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const AdditionalInfoItem({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIconBox(),
          const SizedBox(width: AppSize.s12),
          Expanded(child: _buildInfoText(textTheme)),
        ],
      ),
    );
  }

  Widget _buildIconBox() => Container(
    padding: const EdgeInsets.all(AppPadding.p8),
    decoration: BoxDecoration(
      color: AppColors.secondaryBackground,
      borderRadius: BorderRadius.circular(AppRadius.r8),
    ),
    child: Icon(icon, color: AppColors.defaultIcon, size: AppIconSize.s24),
  );

  Widget _buildInfoText(TextTheme textTheme) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.secondaryText,
        ),
      ),
      const SizedBox(height: AppSize.s4),
      Text(
        value,
        style: textTheme.bodyMedium?.copyWith(color: AppColors.primaryText),
      ),
    ],
  );
}
