import 'package:bookna_app/core/theme/app_colors.dart';
import 'package:bookna_app/core/constants/app_strings.dart';
import 'package:bookna_app/core/constants/app_values.dart';
import 'package:bookna_app/features/catalog/domain/entities/author.dart';
import 'package:bookna_app/features/catalog/presentation/widget/author_info/additional_info_item.dart';
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
    final items = _buildInfoItems();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(context),
        const SizedBox(height: AppSize.s12),
        _buildInfoContainer(items),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) => Text(
    AppStrings.additionalInformation,
    style: Theme.of(context).textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );

  Widget _buildInfoContainer(List<Widget> items) => Container(
    padding: const EdgeInsets.all(AppPadding.p12),
    decoration: BoxDecoration(
      color: AppColors.secondaryBackground,
      borderRadius: BorderRadius.circular(AppRadius.r12),
      boxShadow: [
        BoxShadow(
          color: AppColors.black.withValues(alpha: 0.1),
          blurRadius: AppRadius.r4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children:
          items.isNotEmpty
              ? items
                  .expand(
                    (item) => [item, if (item != items.last) _buildDivider()],
                  )
                  .toList()
              : [_buildEmptyState()],
    ),
  );

  Widget _buildDivider() =>
      const Divider(height: AppSize.s1, color: AppColors.divider, indent: 48);

  Widget _buildEmptyState() => Center(
    child: Text(
      AppStrings.noAdditionalInfoAvailable,
      style: TextStyle(color: Colors.grey[600], fontStyle: FontStyle.italic),
    ),
  );

  List<Widget> _buildInfoItems() => [
    AdditionalInfoItem(
      icon: Icons.person,
      title: AppStrings.authorType,
      value: author.type ?? AppStrings.unknown,
    ),
    if (author.birthDate != null || showAllInfo)
      AdditionalInfoItem(
        icon: Icons.cake,
        title: AppStrings.birthDate,
        value: author.birthDate ?? AppStrings.notAvailable,
      ),
    if (author.deathDate != null || showAllInfo)
      AdditionalInfoItem(
        icon: Icons.event,
        title: AppStrings.deathDate,
        value: author.deathDate ?? AppStrings.notAvailable,
      ),
  ];
}
