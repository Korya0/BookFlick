// ignore_for_file: deprecated_member_use, use_build_context_synchronously
import 'package:bookna_app/core/constants/app_constants.dart';
import 'package:bookna_app/core/constants/app_strings.dart';
import 'package:bookna_app/core/constants/app_values.dart';
import 'package:bookna_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPreviewButton extends StatelessWidget {
  final String? previewLink;

  const DetailsPreviewButton({super.key, required this.previewLink});

  @override
  Widget build(BuildContext context) {
    if (previewLink == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(left: AppPadding.p8),
      child: Align(
        alignment: Alignment.bottomRight,
        child: InkWell(
          onTap: () => _launchURL(context),
          borderRadius: BorderRadius.circular(AppRadius.r25),
          child: _buildIcon(),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: AppConstants.fastAnimationDuration,
      ),
      height: AppSize.s40,
      width: AppSize.s35,
      decoration: const BoxDecoration(
        color: AppColors.secondaryIconContainer,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.chrome_reader_mode,
        color: AppColors.defaultIcon,
        size: AppIconSize.s24,
      ),
    );
  }

  Future<void> _launchURL(BuildContext context) async {
    final url = Uri.parse(previewLink!);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.messageSnackBarLinkBook)),
      );
    }
  }
}
