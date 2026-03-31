import 'package:bookna_app/core/resources/constants/app_constants.dart';
import 'package:bookna_app/core/presentation/widget/image_with_shimmer.dart';
import 'package:bookna_app/core/resources/theme/app_colors.dart';
import 'package:bookna_app/core/resources/constants/app_values.dart';
import 'package:flutter/material.dart';

class SliderCardImage extends StatelessWidget {
  const SliderCardImage({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.dstIn,
      shaderCallback: (rect) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.black, AppColors.black, AppColors.transparent],
          stops: AppConstants.defaultGradientStops,
        ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
      },
      child: ImageWithShimmer(
        height: AppSize.getScreenHeight(context) * 0.6,
        width: AppSize.sInfinity,
        imageUrl: imageUrl,
      ),
    );
  }
}
