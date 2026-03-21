// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:bookna_app/core/presentation/widget/arrow_back_ios_buttom.dart';
import 'package:bookna_app/core/presentation/widget/favorite_icon_bloc_builder.dart';
import 'package:bookna_app/core/presentation/widget/slider_card_image.dart';
import 'package:bookna_app/core/resources/app_colors.dart';
import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:bookna_app/core/resources/app_values.dart';
import 'package:bookna_app/features/books/domain/entities/book.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsCard extends StatelessWidget {
  const DetailsCard({
    required this.detailsWidget,
    super.key,
    required this.book,
  });

  final Widget detailsWidget;
  final Book book;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Stack(
        children: [
          SliderCardImage(imageUrl: book.thumbnail),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: SizedBox(
              height: AppSize.getScreenHeight(context) * 0.6,
              child: Padding(
                padding: const EdgeInsets.only(bottom: AppPadding.p8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: AppSize.getScreenWidth(context) * 0.7,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (book.title != null)
                                  Text(
                                    book.title as String,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: textTheme.titleMedium,
                                  ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: AppPadding.p4,
                                    bottom: AppPadding.p6,
                                  ),
                                  child: detailsWidget,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            spacing: 3,
                            children: [
                              const Icon(
                                Icons.star_rate_rounded,
                                color: AppColors.ratingIcon,
                                size: AppIconSize.s18,
                              ),
                              Text(
                                book.averageRating.toString(),
                                style: textTheme.bodyMedium,
                              ),
                              Text(
                                '(${book.ratingsCount.toString()})',
                                style: textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (book.previewLink != null)
                      Padding(
                        padding: const EdgeInsets.only(left: AppPadding.p8),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            onTap: () async {
                              final url = Uri.parse(book.previewLink ?? '');
                              if (book.previewLink != null &&
                                  await canLaunchUrl(url)) {
                                await launchUrl(
                                  url,
                                  mode: LaunchMode.externalApplication,
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      AppStrings.messageSnackBarLinkBook,
                                    ),
                                  ),
                                );
                              }
                            },
                            borderRadius: BorderRadius.circular(AppRadius.r25),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
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
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: AppPadding.p12,
              left: AppPadding.p16,
              right: AppPadding.p16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const ArrowBackIosButtom(),
                FavoriteIconBlocBuilder(book: book),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
