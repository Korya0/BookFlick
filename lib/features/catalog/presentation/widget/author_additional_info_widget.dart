// ignore_for_file: deprecated_member_use

import 'package:bookna_app/core/resources/theme/app_colors.dart';
import 'package:bookna_app/core/resources/constants/app_strings.dart';
import 'package:bookna_app/core/resources/constants/app_values.dart';
import 'package:bookna_app/features/catalog/domain/entities/author.dart';
import 'package:flutter/material.dart';

class AuthorAdditionalInfoWidget extends StatelessWidget {
  final Author author;
  final bool showAllInfo;

  const AuthorAdditionalInfoWidget({
    super.key,
    required this.author,
    this.showAllInfo = false,
  });

  @override
  Widget build(BuildContext context) {
    final infoItems = _buildInfoItems(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.additionalInformation,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: AppSize.s12),
        Container(
          padding: const EdgeInsets.all(AppPadding.p12),
          decoration: BoxDecoration(
            color: AppColors.secondaryBackground,
            borderRadius: BorderRadius.circular(AppRadius.r12),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.1),
                blurRadius: AppRadius.r4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              if (infoItems.isNotEmpty)
                ...infoItems.expand(
                  (item) => [item, if (item != infoItems.last) _buildDivider()],
                )
              else
                _buildEmptyState(),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _buildInfoItems(BuildContext context) {
    final items = <Widget>[];

    // Add author type
    items.add(
      _buildInfoCard(
        context: context,
        icon: Icons.person,
        title: AppStrings.authorType,
        value: author.type ?? AppStrings.unknown,
      ),
    );

    // Add birth date if available or if showAllInfo is true
    if (author.birthDate != null || showAllInfo) {
      items.add(
        _buildInfoCard(
          context: context,
          icon: Icons.cake,
          title: AppStrings.birthDate,
          value: author.birthDate ?? AppStrings.notAvailable,
        ),
      );
    }

    // Add death date if available or if showAllInfo is true
    if (author.deathDate != null || showAllInfo) {
      items.add(
        _buildInfoCard(
          context: context,
          icon: Icons.event,
          title: AppStrings.deathDate,
          value: author.deathDate ?? AppStrings.notAvailable,
        ),
      );
    }

    return items;
  }

  Widget _buildInfoCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(AppPadding.p8),
            decoration: BoxDecoration(
              color: AppColors.secondaryBackground,
              borderRadius: BorderRadius.circular(AppRadius.r8),
            ),
            child: Icon(
              icon,
              color: AppColors.defaultIcon,
              size: AppIconSize.s24,
            ),
          ),
          const SizedBox(width: AppSize.s12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondaryText,
                  ),
                ),
                const SizedBox(height: AppSize.s4),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.primaryText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: AppSize.s1,
      color: AppColors.divider,
      indent: 48,
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p12),
      child: Center(
        child: Text(
          AppStrings.noAdditionalInfoAvailable,
          style: TextStyle(
            color: Colors.grey[600],
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}
