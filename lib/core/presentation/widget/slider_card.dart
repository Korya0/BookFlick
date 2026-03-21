import 'package:bookna_app/core/presentation/widget/slider_card_image.dart';
import 'package:bookna_app/core/resources/app_colors.dart';
import 'package:bookna_app/core/resources/app_constants.dart';
import 'package:bookna_app/core/resources/app_values.dart';
import 'package:bookna_app/core/utils/functions/format_date.dart';
import 'package:bookna_app/core/utils/functions/route_function.dart';
import 'package:bookna_app/features/books/domain/entities/book.dart';
import 'package:flutter/material.dart';

class SliderCard extends StatelessWidget {
  const SliderCard({
    super.key,
    required this.itemIndex,
    required this.isBook,
    required this.book,
  });

  final int itemIndex;
  final bool isBook;
  final Book book;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        navigateToDetailsView(context, book);
      },
      child: SafeArea(
        child: Stack(
          children: [
            SliderCardImage(imageUrl: book.thumbnail),
            Padding(
              padding: const EdgeInsets.only(
                right: AppPadding.p16,
                left: AppPadding.p16,
                bottom: AppPadding.p10,
              ),
              child: SizedBox(
                height: AppSize.getScreenHeight(context) * 0.55,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (book.title != null)
                      Text(
                        book.title as String,
                        maxLines: 2,
                        style: textTheme.titleMedium,
                      ),

                    Text(
                      formatDate(book.publishedDate),
                      style: textTheme.bodyLarge,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: AppPadding.p4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(
                          AppConstants.carouselSliderItemsCount,
                          (indexDot) {
                            return Container(
                              margin: const EdgeInsets.only(
                                right: AppMargin.m10,
                              ),
                              width:
                                  indexDot == itemIndex
                                      ? AppSize.s30
                                      : AppSize.s6,
                              height: AppSize.s6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  AppRadius.r6,
                                ),
                                color:
                                    indexDot == itemIndex
                                        ? AppColors.activeDot
                                        : AppColors.inactiveDot,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
