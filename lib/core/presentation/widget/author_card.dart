import 'package:bookna_app/core/presentation/widget/image_with_shimmer.dart';
import 'package:bookna_app/core/resources/app_values.dart';
import 'package:flutter/material.dart';

class AuthorCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final Function()? onTap;

  const AuthorCard({
    required this.imageUrl,
    super.key,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: AppSize.s100,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.r8),
              child: ImageWithShimmer(
                imageUrl: imageUrl,
                width: AppSize.sInfinity,
                height: AppSize.s130,
              ),
            ),
            Text(
              name,
              style: textTheme.bodyLarge,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
