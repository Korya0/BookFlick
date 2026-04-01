import 'package:bookna_app/core/constants/app_values.dart';
import 'package:bookna_app/core/presentation/widget/loading/image_with_shimmer.dart';
import 'package:flutter/material.dart';

class CardThumbnail extends StatelessWidget {
  final String? imageUrl;

  const CardThumbnail({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.r8),
        child: ImageWithShimmer(
          imageUrl: imageUrl,
          width: AppSize.s110,
          height: AppSize.sInfinity,
        ),
      ),
    );
  }
}
