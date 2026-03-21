import 'package:bookna_app/core/data/network/api_constants.dart';
import 'package:bookna_app/core/presentation/widget/arrow_back_ios_buttom.dart';
import 'package:bookna_app/core/presentation/widget/image_with_shimmer.dart';
import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:bookna_app/core/resources/app_values.dart';
import 'package:bookna_app/features/books/domain/entities/author.dart';
import 'package:flutter/material.dart';

class AuthorHeaderWidget extends StatelessWidget {
  final Author author;

  const AuthorHeaderWidget({super.key, required this.author});

  @override
  Widget build(BuildContext context) {
    final displayName =
        author.name ??
        (author.alternateNames?.isNotEmpty ?? false
            ? author.alternateNames!.first
            : AppStrings.unknownAuthor);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Stack(
          children: [
            ImageWithShimmer(
              imageUrl: ApiConstants.authorPlaceholder,
              width: AppSize.s100,
              height: AppSize.s150,
            ),
            ArrowBackIosButtom(),
          ],
        ),

        const SizedBox(width: AppSize.s20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                displayName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSize.s8),
              if (author.topWork != null) ...[
                Text(
                  "${AppStrings.topWork}: ${author.topWork}",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                const SizedBox(height: AppSize.s8),
              ],
              if (author.workCount != null) ...[
                Text(
                  '${AppStrings.works}: ${author.workCount}',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                const SizedBox(height: AppSize.s8),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
